import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddReminder extends StatefulWidget {
  final void Function(Timestamp) onReminderAdded;

  AddReminder({
    required this.onReminderAdded,
  });

  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _formKey = GlobalKey<FormState>();
  String? medicineName;
  int? amountPerTime;
  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  bool _isWeeklyRepeatOn = false;

  final List<bool> _isSelected = List.generate(7, (index) => false);

  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  Future<void> saveReminder() async {
    if (_formKey.currentState!.validate() &&
        selectedTime != null &&
        selectedDate != null) {
      final dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      final Timestamp timestamp = Timestamp.fromDate(dateTime);

      CollectionReference reminderRef =
          FirebaseFirestore.instance.collection('MedicineReminderList');

      await reminderRef.doc().set({
        'medName': medicineName,
        'amount': amountPerTime,
        'dateTime': dateTime,
        'userEmail': FirebaseAuth.instance.currentUser!.email,
      });
      widget.onReminderAdded(timestamp);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text('Please fill in all fields and select date and time.'),
          backgroundColor: Colors.red.withOpacity(0.8),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 228, 216),
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.75),
        title: const Text(
          "Add Reminder",
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Medicine Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter the Medicine Name';
                }
                return null;
              },
              onChanged: (value) {
                medicineName = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount per Time'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the amount per time';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onChanged: (value) {
                amountPerTime = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 16),
            const Text('Select times:'),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      icon: const Icon(Icons.access_time),
                      tooltip: 'Select Time',
                    ),
                    if (selectedTime != null)
                      Text(
                        selectedTime!.format(context),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                      tooltip: 'Select Date',
                    ),
                    if (selectedDate != null)
                      Text(
                        DateFormat.yMd().format(selectedDate!),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ToggleButtons(
              isSelected: _isSelected,
              onPressed: (int index) {
                setState(() {
                  _isSelected[index] = !_isSelected[index];
                });
              },
              children: _days.map((day) => Text(day)).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Repeat Weekly:'),
                IconButton(
                  icon: _isWeeklyRepeatOn
                      ? const Icon(Icons.check_box_rounded)
                      : const Icon(Icons.square_outlined),
                  onPressed: () {
                    setState(() {
                      _isWeeklyRepeatOn = !_isWeeklyRepeatOn;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {
                  print('Button pressed');
                  saveReminder();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}