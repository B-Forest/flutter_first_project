import 'package:first_flutter_project/widgets/skill.dart';
import 'package:flutter/material.dart';

class Gauge extends StatelessWidget {

  final String title;
  final double value;

  const Gauge(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Skill(title),
          LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
