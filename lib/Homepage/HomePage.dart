// ignore_for_file: use_key_in_widget_constructors, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';
import 'BottomHomePage.dart';
import 'BottomMenuPage.dart';
import 'BottomProfilePage.dart';
import 'BottomEditProfilePage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final BottomPages = [
    BottomHomePage(),
    BottomProfilePage(),
    BottomEditProfilePage(),
    BottomMenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
            ),
            Text(
              user.email!,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: BottomPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 20,
        selectedFontSize: 18,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            label: 'Profile',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.clipboard_outline),
            label: 'Edit Profile',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.menu_outline),
            label: 'Menu',
            backgroundColor: Color.fromARGB(255, 155, 191, 224),
          ),
        ],
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}