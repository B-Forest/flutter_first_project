import 'package:flutter/material.dart';

class Skill extends StatelessWidget {

  final String title;

  const Skill(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
      ]
    );
  }
}
