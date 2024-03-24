import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LinearPercentIndicator(
          width: 200,
          alignment: MainAxisAlignment.center,
          percent: 0.8,
          center: Text("${0.8 * 100}%"),
          lineHeight: 20,
          barRadius: Radius.circular(15),
        ),
      ),
    );
  }
}
