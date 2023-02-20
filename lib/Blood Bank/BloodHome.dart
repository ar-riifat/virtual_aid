import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BloodHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 212, 214),
      appBar: AppBar(
        title: const Text("Blood Bank"),
        actions: [
          PopupMenuButton<int>(
            color: const Color.fromARGB(255, 204, 200, 200),
            icon: const Icon(Icons.menu),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('List All Donor'),
              ),
            ],
            onSelected: (int value) {
              if (value == 0) {}
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      radius: 30,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Welcome, ",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.email!,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 10),
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "   Search for Blood Group......",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.blue,
                    // ),
                    padding: const EdgeInsets.only(
                      left: 5,
                      top: 10,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                    child: const Text(
                      'Blood Group',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: bloodGroup.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Container(
                            width: 50,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF2F8FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List bloodGroup = [
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
];
