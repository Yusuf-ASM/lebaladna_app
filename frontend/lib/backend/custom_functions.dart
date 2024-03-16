// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'shared_variables.dart';
import 'package:dio/dio.dart';

Future<bool> checkInternetConnection() async {
  if (Testing) {
    return true;
  }
  Dio dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 3)));
  try {
    await dio.get('https://example.com');
    return true;
  } on DioException catch (_) {
    return false;
  }
}

void writeLog<T>(String functionName, T text) {
  String log = box.get("log") ?? "";
  log += "[$functionName] - [${DateTime.now()}] - log: $text\n";
  if (Testing) {
    print("\x1B[33m[$functionName] - [${DateTime.now()}] - log: $text\x1B[0m");
  }
  box.put("log", log);
}

void writeError<T>(String functionName, T error) {
  String log = box.get("log") ?? "";
  log += "[$functionName] - [${DateTime.now()}] - error: $error\n";
  if (Testing) {
    print("\x1B[31m[$functionName] - [${DateTime.now()}] - error: $error\x1B[0m");
  }
  box.put("log", log);
}

// String int2Time(int time) {
//   if (time < 12) {
//     return RTL ? "$time ص" : "$time AM";
//   } else if (time == 12) {
//     return RTL ? "$time م" : "$time PM";
//   }
//   return RTL ? "${time - 12} م" : "${time - 12} PM";
// }

class LoadingStateNotifier with ChangeNotifier {
  LoadingStateNotifier({this.loading = true});
  bool loading = true;
  List<dynamic> response = [];
  void change() {
    loading = !loading;
    notifyListeners();
  }
}

class UserStateNotifier with ChangeNotifier {
  UserStateNotifier.signInStateNotifier();
  static final UserStateNotifier _instance = UserStateNotifier.signInStateNotifier();
  factory UserStateNotifier() {
    return _instance;
  }
  bool signed = box.get("signed") ?? false;
  void logout() {
    signed = false;
    box.put("signed", false);
    notifyListeners();
  }

  void login() {
    signed = true;
    box.put("signed", true);
    notifyListeners();
  }
}

class VariableNotifier<T> with ChangeNotifier {
  void change() {
    notifyListeners();
  }
}

int currentTimeEpoch() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, 2).millisecondsSinceEpoch ~/ 1000;
}

void connectWebSocket() {
  if (channel == null) {
    channel = WebSocketChannel.connect(Uri.parse(webSocketLink));
    stream = channel?.stream.asBroadcastStream();
  }
}
