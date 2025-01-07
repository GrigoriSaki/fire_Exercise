// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_exercises/components/myButton.dart';
import 'package:fire_exercises/components/textField.dart';
import 'package:fire_exercises/helperFunctions/messageForUser.dart';
import 'package:fire_exercises/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordRepeatController = TextEditingController();

  void registerUser() async {
    if (emailController.text.isEmpty ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      displayErrorToUser(context, "All fields must be filled in !!!");
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              //circular indicator
              const Center(child: CircularProgressIndicator()));
    }

    //make sure password
    if (passwordController.text != passwordRepeatController.text) {
      //circular progress
      Navigator.pop(context);
      //show error
      displayErrorToUser(context, 'Check the passwords ;)');
    } else {
      //try creating the user
      try {
        // ignore: unused_local_variable
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        //Create a user in the database
        createUserDocument(userCredential);

        if (context.mounted) Navigator.pop(context);

        nameController.clear();
        emailController.clear();
        passwordController.clear();
        passwordRepeatController.clear();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.pop(context);
          displayErrorToUser(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Navigator.pop(context);
          displayErrorToUser(
              context, 'The account already exists for that email.');
        } else if (e.code == 'invalid-email') {
          Navigator.pop(context);
          displayErrorToUser(context, 'Invalid email');
        }
      } catch (e) {
        Navigator.pop(context);
        // ignore: avoid_print
        print(e);
      }
    }
  }

  //Create a user Document
  Future<void> createUserDocument(UserCredential userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.email)
          .set({
        'userName': nameController.text,
        'email': emailController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
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
                  controller: nameController),
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
              MyButton(
                  onTap: () {
                    registerUser();
                  },
                  text: 'REGISTER'),
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
      ),
    );
  }
}
