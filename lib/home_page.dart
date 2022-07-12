// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/pages/account.dart';
import 'package:przepisy/pages/favorite.dart';
import 'package:przepisy/pages/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  void navigate(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  final List<Widget> pages = [
    Home(),
    Favorite(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: CurvedNavigationBar(
          color: Colors.grey.shade100,
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 450),
          onTap: navigate,
          items: [
            Icon(Icons.home_outlined),
            Icon(Icons.favorite_outline),
            Icon(Icons.person_outline),
          ]),
    );
  }
}
