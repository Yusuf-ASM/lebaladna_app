import 'package:flutter/material.dart';
import 'package:lebaladna/pages/intro_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'backend/shared_variables.dart';

// okie
Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("lebaladna");

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      theme: ThemeData(colorSchemeSeed: mainColor),
    );
  }
}
