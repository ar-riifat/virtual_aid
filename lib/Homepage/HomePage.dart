//ignore_for_file: use_key_in_widget_constructors, file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
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

  late Future<QuerySnapshot> _futureSnapshot;

  @override
  void initState() {
    super.initState();
    _futureSnapshot = FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _futureSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went Wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                ),
                Text(
                  '${snapshot.data!.docs.first['name']}',
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
      },
    );
  }
}
