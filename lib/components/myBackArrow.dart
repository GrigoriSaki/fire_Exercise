import 'package:flutter/material.dart';

class Mybackarrow extends StatelessWidget {
  const Mybackarrow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 35,
              ),
            )));
  }
}
