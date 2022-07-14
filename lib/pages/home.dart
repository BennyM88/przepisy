// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:przepisy/extras/recipe_card.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8)),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                      hintText: 'Szukaj...',
                      hintStyle: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Przepisy',
                style: TextStyle(fontSize: 22),
              ),
            ),
            SizedBox(height: 10),
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
                        Tab(text: 'Wszytskie'),
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
                      height: 240,
                      width: double.maxFinite,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Popularne',
                style: TextStyle(fontSize: 22),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(color: Colors.black),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
