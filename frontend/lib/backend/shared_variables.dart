// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const Link = Testing ? "127.0.0.1" : "192.168.3.100";
const BackendLink = "http://$Link:8080";
const webSocketLink = "ws://$Link:8080/ws";
const UserBackendLink = "http://$Link:8080/user";
const AdminBackendLink = "http://$Link:8080/admin";
const KitchenBackendLink = "http://$Link:8080/kitchen";
const StationBackendLink = "http://$Link:8080/station";
const FacilitatorBackendLink = "http://$Link:8080/facilitator";

WebSocketChannel? channel;
Stream? stream;
const Version = "V1.0";
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