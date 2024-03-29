import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:przepisy/constants.dart';
import 'package:przepisy/widgets/recipe_grid.dart';

class FavoriteRecipes extends StatefulWidget {
  const FavoriteRecipes({Key? key}) : super(key: key);

  @override
  State<FavoriteRecipes> createState() => _FavoriteRecipesState();
}

class _FavoriteRecipesState extends State<FavoriteRecipes> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                //title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                  child: Row(
                    children: [
                      Text(
                        'your_fav'.tr,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        'recipess'.tr,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //grid of fav
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: smallPadding / 2),
                  child: SizedBox(
                      height: size.height * 0.75,
                      child: Column(
                        children: const [
                          Expanded(
                            child: RecipeGrid(),
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
