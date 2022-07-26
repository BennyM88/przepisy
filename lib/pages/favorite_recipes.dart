// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:przepisy/constants.dart';
import 'package:przepisy/extras/recipe_grid.dart';

class FavoriteRecipes extends StatefulWidget {
  const FavoriteRecipes({Key? key}) : super(key: key);

  @override
  State<FavoriteRecipes> createState() => _FavoriteRecipesState();
}

class _FavoriteRecipesState extends State<FavoriteRecipes> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                //title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                  child: Row(
                    children: [
                      Text(
                        'Twoje ulubione ',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        'przepisy',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //grid of fav
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: smallPadding / 2),
                  child: SizedBox(
                      height: size.height * 0.75,
                      child: Column(
                        children: [
                          Expanded(child: RecipeGrid()),
                        ],
                      )),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
