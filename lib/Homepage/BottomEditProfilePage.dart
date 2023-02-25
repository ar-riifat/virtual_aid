// ignore_for_file: use_key_in_widget_constructors, file_names

import 'dart:io';

import 'package:flutter/material.dart';

class BottomEditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: const Text(
                'Exit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}