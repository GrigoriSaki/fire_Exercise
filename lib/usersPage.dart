import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_exercises/components/myBackArrow.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            //CircularProgressIndicator while waiting for data
            if (ConnectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            //Error display
            else if (snapshot.hasError) {
              return Center(
                child: Text("ERROR: ${snapshot.error}"),
              );
            }

            //display Users
            else if (snapshot.hasData) {
              final users = snapshot.data!.docs;
              return Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Mybackarrow(),
                      SizedBox(width: 100),
                      Text('USERS', style: TextStyle(fontSize: 26)),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            tileColor: Theme.of(context).colorScheme.secondary,
                            title: Text(
                              user['userName'],
                              style: TextStyle(),
                            ),
                            subtitle: Text(user['email']),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('No users found'),
              );
            }
          }),
    );
  }
}
