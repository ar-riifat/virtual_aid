import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';

class DonorList extends StatefulWidget{
  @override
  State<DonorList> createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
  late final Stream<QuerySnapshot> _DonorDetailsStream;
@override
Widget build(BuildContext contex){
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 243, 197, 193),
    appBar: AppBar(
        title: const Text('Blood Bank'),
        backgroundColor: Colors.red.withOpacity(0.85),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _DonorDetailsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return const Text("Something went wrong");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(
              color: Colors.green
            ),
            );
          }
          if (snapshot.data!.docs.isEmpty){
            return const Center(
              child: Text(
                "The List If Empty",
              )
            );
          }

          return Material(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext contex, int index){
                return Container();
              },
            ),
          );
        },
      )
  );
}
}
