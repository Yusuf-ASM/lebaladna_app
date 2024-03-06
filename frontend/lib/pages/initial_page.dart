import 'package:flutter/material.dart';
import 'package:lebaladna/pages/home_page.dart';
import 'package:lebaladna/pages/login_page.dart';

import '../../backend/custom_functions.dart';
import '../../backend/shared_variables.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signInStateNotifier = SignInStateNotifier();
    // TODO remove in production
    // box.put("signInState", false);
    return ListenableBuilder(
      listenable: signInStateNotifier,
      builder: (context, child) {
        if (box.get("signInState")) {
          headers["_id"] = box.get("_id");
          headers["token"] = box.get("token");
          return const HomePage();
        }
        return LoginPage();
      },
    );
  }
}
