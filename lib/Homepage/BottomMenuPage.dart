// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, file_names
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomMenuPage extends StatefulWidget {
  @override
  _BottomMenuPageState createState() => _BottomMenuPageState();
}

class _BottomMenuPageState extends State<BottomMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E4EE),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  width: 300,
                  animType: AnimType.bottomSlide,
                  dismissOnTouchOutside: true,
                  dismissOnBackKeyPress: false,
                  title: 'LOG OUT',
                  desc: 'Are You Sure You Want to Log Out?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () => FirebaseAuth.instance.signOut(),
                ).show();
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  width: 300,
                  animType: AnimType.bottomSlide,
                  dismissOnTouchOutside: true,
                  dismissOnBackKeyPress: false,
                  title: 'Exit',
                  desc: 'Are You Sure You Want to Exit?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () => exit(0),
                ).show();
              },
            ),
          ],
        ),
      ),
    );
  }
}