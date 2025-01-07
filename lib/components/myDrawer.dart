import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../loginPage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 225,
              bottom: 55,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 50,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'User Name',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 50,
                  ),

                  //HOME Button
                  ListTile(
                    title: Text('Home', style: TextStyle(fontSize: 20)),
                    leading: Icon(Icons.home, size: 34),
                    onTap: () {
                      Navigator.pushNamed(context, 'home page');
                    },
                  ),

                  //PROFILE Button
                  ListTile(
                    title: Text('Profile', style: TextStyle(fontSize: 20)),
                    leading: Icon(
                      Icons.person,
                      size: 34,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'profile page');
                    },
                  ),

                  //USERS Button
                  ListTile(
                    title: Text('Users', style: TextStyle(fontSize: 20)),
                    leading: Icon(Icons.people, size: 34),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'users page');
                    },
                  ),
                ],
              ),
              //LOGOUT Button
              ListTile(
                title: Text('Log Out', style: TextStyle(fontSize: 20)),
                leading: Icon(
                  Icons.logout,
                  size: 34,
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
