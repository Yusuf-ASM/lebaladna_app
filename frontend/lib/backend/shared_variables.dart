// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const BackendLink = Testing ? "http://127.0.0.1:8080" : "https://lebaladnab.nucoders.dev";
const webSocketLink = Testing ? "ws://127.0.0.1:8080/ws" : "wss://lebaladnab.nucoders.dev/ws";
const UserBackendLink =
    Testing ? "http://127.0.0.1:8080/user" : "https://lebaladnab.nucoders.dev/user";
const AdminBackendLink =
    Testing ? "http://127.0.0.1:8080/admin" : "https://lebaladnab.nucoders.dev/admin";
const KitchenBackendLink =
    Testing ? "http://127.0.0.1:8080/kitchen" : "https://lebaladnab.nucoders.dev/kitchen";
const StationBackendLink =
    Testing ? "http://127.0.0.1:8080/station" : "https://lebaladnab.nucoders.dev/station";
const FacilitatorBackendLink =
    Testing ? "http://127.0.0.1:8080/facilitator" : "https://lebaladnab.nucoders.dev/facilitator";

WebSocketChannel? channel;
Stream? stream;
const Version = "V1.0.5";
const Testing = false;
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
