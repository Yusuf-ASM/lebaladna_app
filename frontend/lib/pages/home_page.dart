import 'package:flutter/material.dart';
import 'package:frontend/pages/intro_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return const IntroPage();
  }
}
