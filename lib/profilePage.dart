import 'package:cloud_firestore/cloud_firestore.dart';
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
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile'),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.person_outline,
              size: 34,
            ),
          ],
        ),
      ),
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

              //Display user details
              return Center(
                child: Column(
                  children: [
                    Text('User Name: ${user['userName']}'),
                    SizedBox(
                      height: 50,
                    ),
                    Text("User Email: ${user['email']}")
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
