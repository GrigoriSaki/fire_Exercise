import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Users'),
            SizedBox(width: 10),
            Icon(
              Icons.people,
              size: 34,
            ),
          ],
        ),
      ),
    );
  }
}
