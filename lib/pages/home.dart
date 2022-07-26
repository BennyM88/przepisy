// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:przepisy/constants.dart';
import 'package:przepisy/extras/show_recipe_details.dart';
import 'package:przepisy/widgets/recipe_card.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:przepisy/pages/recipe_details.dart';
import 'package:przepisy/widgets/recipe_stripes.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> data = [];
  List<String> doc = [];

  CollectionReference recipe =
      FirebaseFirestore.instance.collection('przepisy-details');

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await recipe.get();

    final allDishNames =
        querySnapshot.docs.map((doc) => doc.get('dish name')).toList();

    data = allDishNames.map((e) => e.toString()).toList();

    recipe.get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              doc.add(document.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                //title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                  child: Row(
                    children: [
                      Text(
                        'find_your'.tr,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        'recipe'.tr,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //search bar
                GestureDetector(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate:
                          CustomSearchDelegate(searchTerms: data, docIDs: doc),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: smallPadding),
                    child: Container(
                      padding: const EdgeInsets.only(left: smallPadding / 2),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey.shade600),
                            const SizedBox(width: 10),
                            Text(
                              'search'.tr,
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //titile
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                  child: Text(
                    'recipes'.tr,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(height: 10),
                //list of all recipes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                  child: DefaultTabController(
                    length: 4,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(text: 'all'.tr),
                            Tab(text: 'breakfasts'.tr),
                            Tab(text: 'dinners'.tr),
                            Tab(text: 'desserts'.tr),
                          ],
                          indicator: DotIndicator(
                            color: Colors.black,
                            distanceFromCenter: 16,
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black.withOpacity(0.3),
                          labelPadding: const EdgeInsets.symmetric(
                              horizontal: smallPadding),
                        ),
                        SizedBox(
                          height: size.height * 0.3,
                          child: TabBarView(
                            children: [
                              RecipeCard(category: 'w'),
                              RecipeCard(category: 's'),
                              RecipeCard(category: 'o'),
                              RecipeCard(category: 'd'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                  child: Text(
                    'popular'.tr,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(height: 10),
                //list of popular recipes
                SizedBox(
                  height: size.height * 0.2,
                  child: const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: smallPadding),
                      child: RecipeStripes(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.searchTerms, required this.docIDs});
  List<String> searchTerms = [];
  List<String> docIDs = [];

  int findIndex(var item) {
    int index = searchTerms.indexWhere((element) => element.contains(item));
    return index;
  }

  @override
  String? get searchFieldLabel => 'search'.tr;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 96) / 2;
    final double itemWidth = size.width / 2;
    for (var x in searchTerms) {
      if (x.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(x);
      }
    }
    return GridView.builder(
      itemCount: matchQuery.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: itemWidth / itemHeight),
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RecipeDetails(docID: docIDs[findIndex(result)])));
          },
          child: Padding(
            padding: const EdgeInsets.all(smallPadding / 2),
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.35,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(1, 2),
                        blurRadius: 8,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: ShowImage(
                      docID: docIDs[findIndex(result)],
                      width: size.width / 2,
                      height: size.height * 0.26),
                ),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: itemHeight / 9,
                  left: 10,
                  child: ShowRecipeDetails(
                    docID: docIDs[findIndex(result)],
                    isBlack: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var x in searchTerms) {
      if (x.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(x);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RecipeDetails(docID: docIDs[findIndex(result)])));
          },
          child: ListTile(
            title: Text(result,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            leading: const Icon(Icons.search),
          ),
        );
      },
    );
  }
}
