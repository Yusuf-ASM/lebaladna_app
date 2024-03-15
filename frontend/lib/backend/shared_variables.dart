// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const BackendLink = "http://127.0.0.1:8080";
const webSocketLink = "ws://127.0.0.1:8080/ws";
const UserBackendLink = "http://127.0.0.1:8080/user";
const AdminBackendLink = "http://127.0.0.1:8080/admin";
const KitchenBackendLink = "http://127.0.0.1:8080/kitchen";
const StationBackendLink = "http://127.0.0.1:8080/station";
const FacilitatorBackendLink = "http://127.0.0.1:8080/facilitator";
WebSocketChannel? channel;
const Testing = true;
const TextFieldBorderRadius = 15.0;
const NormalTextSize = 16.0;
const SemiTextSize = 18.0;
const MediumTextSize = 24.0;
const BigTextSize = 32.0;

Map<String, String> headers = {};

Box box = Hive.box("lebaladna");

List<String> stringKeys = ["_id", "name", "token"];
List<String> booleanKeys = ["signed"];

const mainColor = Color.fromARGB(255, 39, 178, 243);
const secondColor = Colors.blue;
const thirdColor = Color.fromARGB(255, 45, 130, 199);
