import 'package:fire_exercises/components/myButton.dart';
import 'package:fire_exercises/components/textField.dart';
import 'package:fire_exercises/loginPage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo
            Icon(
              Icons.person,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            //Title
            Text(
              'M Y  N O T E S',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 25,
            ),

            //TextFields
            MyTextField(
                hintText: 'Enter name',
                obscureText: false,
                controller: emailController),
            SizedBox(
              height: 10,
            ),
            MyTextField(
                hintText: 'Enter email',
                obscureText: false,
                controller: emailController),
            SizedBox(
              height: 10,
            ),
            MyTextField(
                hintText: 'Enter password',
                obscureText: true,
                controller: passwordController),
            SizedBox(
              height: 10,
            ),
            MyTextField(
                hintText: 'Repeat password',
                obscureText: true,
                controller: passwordRepeatController),

            SizedBox(
              height: 25,
            ),

            //Login Button
            MyButton(onTap: () {}, text: 'REGISTER'),
            SizedBox(
              height: 8,
            ),

            //have an account, Login Here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You have an account? ",
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Login HERE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey.shade500),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
