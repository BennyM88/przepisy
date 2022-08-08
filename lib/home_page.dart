// ignore_for_file: prefer_const_constructors

import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:przepisy/pages/account/account.dart';
import 'package:przepisy/pages/favorite/favorite.dart';
import 'package:przepisy/pages/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  void _navigate(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  final List<Widget> _pages = [
    Home(),
    Favorite(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: _pages[_selectedPage],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.grey.shade100,
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 450),
        onTap: _navigate,
        items: const [
          Icon(Icons.home_outlined),
          Icon(Icons.favorite_outline),
          Icon(Icons.person_outline),
        ],
      ),
    );
  }
}
