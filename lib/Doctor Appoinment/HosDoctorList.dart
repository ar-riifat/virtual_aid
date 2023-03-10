// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AddDoctor.dart';
import 'DoctorDetails.dart';

class HosDoctorList extends StatefulWidget {
  final String hospitalsName;

  HosDoctorList({
    required this.hospitalsName,
  });
  @override
  State<HosDoctorList> createState() => _HosDoctorListState();
}

class _HosDoctorListState extends State<HosDoctorList> {
  late final Stream<QuerySnapshot> _DoctorsDetailsStream;

  @override
  void initState() {
    super.initState();
    _DoctorsDetailsStream = FirebaseFirestore.instance
        .collection('DoctorList')
        .where('hospital', isEqualTo: widget.hospitalsName)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _DoctorsDetailsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "This list is Empty",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return Material(
            color: const Color(0xFFD9E4EE),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetails(
                            doctorDetails: snapshot.data!.docs[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white60,
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  snapshot.data!.docs[index]['doctorImage'],
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data!.docs[index]['name'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['specialist'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['hospital'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['age']
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          if (FirebaseAuth.instance.currentUser!.email ==
                              'nimda884@gmail.com')
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Delete Doctor'),
                                        content: const Text(
                                            'Are you sure you want to delete this doctor?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Delete'),
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('DoctorList')
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .delete();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton:
          FirebaseAuth.instance.currentUser!.email == 'nimda884@gmail.com'
              ? FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDoctor(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : null,
    );
  }
}
