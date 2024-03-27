import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // double maxWidth = width * 0.9;

    return const Scaffold(
      body: Center(),
    );
  }
}
