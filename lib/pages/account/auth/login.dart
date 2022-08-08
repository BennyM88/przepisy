import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:przepisy/constants.dart';
import 'package:przepisy/extras/country.dart';
import 'package:przepisy/pages/account/account.dart';
import 'package:przepisy/pages/account/auth/forgot_pswd.dart';
import 'package:przepisy/transitions/enter_exit_route.dart';
import 'package:przepisy/widgets/email_text_field.dart';
import 'package:przepisy/widgets/loading.dart';
import 'package:przepisy/widgets/pswd_text_field.dart';
import 'package:przepisy/widgets/snack_bar.dart';

class Login extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const Login({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    _isLoading = true;
    setState(() {});

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (_) {
      SnackBarWidget.infoSnackBar(context, 'incorrect_data'.tr, Colors.red);
    }

    _isLoading = false;
    setState(() {});
  }

  Future<void> _signInWithGoogle() async {
    _isLoading = true;
    setState(() {});

    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    _isLoading = false;
    if (mounted) setState(() {});
  }

  void _changeLanguage(Country country) {
    var localeUS = const Locale('en', 'US');
    var localePL = const Locale('pl', 'PL');
    if (country.countryCode == 'US') {
      Get.updateLocale(localeUS);
    } else if (country.countryCode == 'PL') {
      Get.updateLocale(localePL);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              icon: const Icon(
                Icons.language,
                color: primaryColor,
              ),
              underline: const SizedBox(),
              items: Country.languageList()
                  .map<DropdownMenuItem<Country>>(
                    (lang) => DropdownMenuItem(
                      value: lang,
                      child: Row(
                        children: [
                          Text(lang.flag),
                          Text(lang.name),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (Country? country) {
                _changeLanguage(country!);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? const Loading()
              : SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //logo
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: bigPadding + 5),
                          child: Image.asset('assets/logo.png',
                              width: double.infinity,
                              height: size.height * 0.07),
                        ),
                        const SizedBox(height: 20),
                        //email text
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: bigPadding + 5),
                          child: Text('E-MAIL'),
                        ),
                        const SizedBox(height: 10),
                        //email textfield
                        emailTextField(_emailController),
                        const SizedBox(height: 25),
                        //password text
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: bigPadding + 5),
                          child: Text('pswd'.tr),
                        ),
                        const SizedBox(height: 10),
                        //password textfield
                        pswdTextField(_passwordController),
                        const SizedBox(height: 50),
                        //login button & forgot pswd
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: bigPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: _signIn,
                                child: Container(
                                  width: size.width * 0.4,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'sign_in'.tr,
                                      style: const TextStyle(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      EnterExitRoute(
                                          exitPage: const Account(),
                                          enterPage: const ForgotPassword()));
                                },
                                child: Text(
                                  'forgot_pswd'.tr,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        //connect with google
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: smallPadding),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: primaryColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text('connect_with'.tr),
                              ),
                              const Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: _signInWithGoogle,
                          child: Center(
                            child: Image.asset('assets/google.png'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //create a new acc
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'create_acc'.tr,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.arrow_right),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
