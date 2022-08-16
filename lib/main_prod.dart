import 'package:przepisy/config/environment.dart';
import 'package:przepisy/main.dart';

Future<void> main() async {
  await mainCommon(Environment.prod);
}
