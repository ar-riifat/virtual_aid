import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AddReminder.dart';
import 'package:timezone/timezone.dart' as tz;

import 'NotificationApi.dart';

class MedicineReminder extends StatefulWidget {
  @override
  State<MedicineReminder> createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  @override
  void initState() {
   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

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
            onPressed: () {},
            child: const Text("Notification"),
          ),
        ),
      ),
    );
  }
}