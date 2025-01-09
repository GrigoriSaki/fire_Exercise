import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_exercises/components/myBackArrow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            //CircularProgressIndicator while waiting for data
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
              //Display error if any
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;
              String userName = user['userName'];

              //Display user details
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Mybackarrow(),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.secondary),
                      child: Icon(Icons.person_outline, size: 100),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      userName,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${user['email']}",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("Has no DATA"),
              );
            }
          }),
    );
  }
}
