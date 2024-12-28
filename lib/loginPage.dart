import 'package:fire_exercises/components/myButton.dart';
import 'package:fire_exercises/components/textField.dart';
import 'package:fire_exercises/registerPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void logIn() {}
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

            //Forgot Password?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Forgot password?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),

            //Login Button
            MyButton(
                onTap: () {
                  logIn();
                },
                text: 'LOG IN'),
            SizedBox(
              height: 8,
            ),

            //Dont have account, Register Here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't You have an account? ",
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    "Register HERE",
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
