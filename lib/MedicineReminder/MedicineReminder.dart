import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AddReminder.dart';

class MedicineReminder extends StatefulWidget {
  @override
  State<MedicineReminder> createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Med"),
      ),
      body: Material(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return AddReminder();
                  },
                ),
              );
            },
            child: const Text("Notification"),
          ),
        ),
      ),
    );
  }
}
