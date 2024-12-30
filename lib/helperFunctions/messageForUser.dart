import 'package:flutter/material.dart';

//display error message to user

void displayErrorToUser(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(message),
          ));
}
