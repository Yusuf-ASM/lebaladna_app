import 'package:flutter/material.dart';
import 'package:lebaladna/backend/text.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../backend/api/user_api.dart';
import '../../backend/custom_functions.dart';
import '../../backend/shared_variables.dart';
import '../../components/shared_components.dart';

Future<void> loginButton({
  required String name,
  required String password,
  required BuildContext context,
}) async {
  FocusScope.of(context).unfocus();
  name = name.trim().toLowerCase();
  final signInStateNotifier = UserStateNotifier();

  if (name.isNotEmpty && password.isNotEmpty) {
    loadingIndicatorDialog(context);
    final response = await login({"name": name, "password": password});
    if (context.mounted) {
      Navigator.of(context).pop();
      if (response[0] == 200) {
        box.put("name", name);
        box.put("_id", response[1]['_id']);
        box.put("token", response[1]['token']);
        channel = WebSocketChannel.connect(Uri.parse(webSocketLink));
        signInStateNotifier.login();
      } else {
        snackBar(response[1], context);
      }
    }
  } else {
    snackBar(textFillUsernamePassword, context);
  }
}
