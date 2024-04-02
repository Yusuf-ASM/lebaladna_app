import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../backend/shared_variables.dart';
import '../../backend/custom_functions.dart';
import 'initial_page.dart';

class IntroPage extends StatefulWidget {
  final bool displayOnly;
  const IntroPage({super.key, this.displayOnly = false});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        initializing().then(
          (value) => Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => InitialPage(),
            ),
            (route) => false,
          ),
        );
      },
    );

    return const SafeArea(
      child: Scaffold(
        body: Center(
            child: Text(
          "Lebaladna",
          style: TextStyle(fontSize: BigTextSize, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

Future<void> initializing() async {
  for (var key in stringKeys) {
    if (box.get(key) == null) {
      box.put(key, "");
    }
  }
  writeLog("IntroPage - Initializing", "Done Initializing String keys");
  for (var key in booleanKeys) {
    if (box.get(key) == null) {
      box.put(key, false);
    }
  }
  writeLog("IntroPage - Initializing", "Done Initializing Boolean keys");
}
