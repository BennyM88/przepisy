// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/extras/get_recipe_details.dart';
import 'package:przepisy/extras/recipe_card.dart';
import 'package:przepisy/extras/show_image.dart';
import 'package:przepisy/pages/recipe_details.dart';
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

  Future getData() async {
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
                SizedBox(height: 20),
                //title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        'Znajdź swój ',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        'przepis',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey.shade600),
                            SizedBox(width: 10),
                            Text(
                              'Szukaj...',
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //titile
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Przepisy',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(height: 10),
                //list of all recipes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DefaultTabController(
                    length: 4,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(text: 'Wszystkie'),
                            Tab(text: 'Śniadania'),
                            Tab(text: 'Obiady'),
                            Tab(text: 'Desery'),
                          ],
                          indicator: DotIndicator(
                            color: Colors.black,
                            distanceFromCenter: 16,
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black.withOpacity(0.3),
                          labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
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
                SizedBox(height: 20),
                //title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Popularne',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                SizedBox(height: 20),
                //list of popular recipes
                SizedBox(
                  height: size.height * 0.15,
                  child: Expanded(
                    child: Container(color: Colors.black),
                  ),
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

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.searchTerms, required this.docIDs});
  List<String> searchTerms = [];
  List<String> docIDs = [];

  int findIndex(var item) {
    int index = searchTerms.indexWhere((element) => element.contains(item));
    return index;
  }

  @override
  String? get searchFieldLabel => 'Szukaj...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_rounded),
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
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Container(
                  height: 270,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: Offset(1, 2),
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
                      height: 200),
                ),
                Positioned(
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
                  child: GetRecipeDetails(docID: docIDs[findIndex(result)]),
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
            title: Text(result, style: TextStyle(fontWeight: FontWeight.bold)),
            leading: Icon(Icons.search),
          ),
        );
      },
    );
  }
}
