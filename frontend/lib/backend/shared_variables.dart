// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'custom_functions.dart';

const BackendLink = "http://127.0.0.1:8080";
const Testing = true;
const RTL = true;
const TD = RTL ? TextDirection.rtl : TextDirection.ltr;
const TextFieldBorderRadius = 15.0;
const NormalTextSize = 16.0;
const SemiTextSize = 18.0;
const MediumTextSize = 24.0;
const BigTextSize = 32.0;

List<String> appointmentStatusList = ["reserved", "taken", "postponed", "lost"];

List<DropdownMenuItem> appointmentStatus = [
  DropdownMenuItem(
    value: 0,
    child: Text(
      appointmentStatusList[0],
      style: const TextStyle(fontSize: SemiTextSize),
    ),
  ),
  DropdownMenuItem(
    value: 1,
    child: Text(
      appointmentStatusList[1],
      style: const TextStyle(fontSize: SemiTextSize),
    ),
  ),
  DropdownMenuItem(
    value: 2,
    child: Text(
      appointmentStatusList[2],
      style: const TextStyle(fontSize: SemiTextSize),
    ),
  ),
  DropdownMenuItem(
    value: 3,
    child: Text(
      appointmentStatusList[3],
      style: const TextStyle(fontSize: SemiTextSize),
    ),
  ),
];

List<DropdownMenuItem> times = [
  DropdownMenuItem(
    value: 8,
    child: Text(
      int2Time(8),
    ),
  ),
  DropdownMenuItem(
    value: 9,
    child: Text(
      int2Time(9),
    ),
  ),
  DropdownMenuItem(
    value: 10,
    child: Text(
      int2Time(10),
    ),
  ),
  DropdownMenuItem(
    value: 11,
    child: Text(
      int2Time(11),
    ),
  ),
  DropdownMenuItem(
    value: 12,
    child: Text(
      int2Time(12),
    ),
  ),
  DropdownMenuItem(
    value: 13,
    child: Text(
      int2Time(13),
    ),
  ),
  DropdownMenuItem(
    value: 14,
    child: Text(
      int2Time(14),
    ),
  ),
  DropdownMenuItem(
    value: 15,
    child: Text(
      int2Time(15),
    ),
  ),
  DropdownMenuItem(
    value: 16,
    child: Text(
      int2Time(16),
    ),
  ),
  DropdownMenuItem(
    value: 17,
    child: Text(
      int2Time(17),
    ),
  ),
  DropdownMenuItem(
    value: 18,
    child: Text(
      int2Time(18),
    ),
  ),
  DropdownMenuItem(
    value: 19,
    child: Text(
      int2Time(19),
    ),
  ),
  DropdownMenuItem(
    value: 20,
    child: Text(
      int2Time(20),
    ),
  ),
  DropdownMenuItem(
    value: 21,
    child: Text(
      int2Time(21),
    ),
  ),
  DropdownMenuItem(
    value: 22,
    child: Text(
      int2Time(22),
    ),
  ),
];

Map<String, String> headers = {};
Box box = Hive.box("student");

List<String> stringKeys = [
  "_id",
  "name",
  "token",
  "permissions" // it is a json but XD
];
List<String> booleanKeys = ["signInState"];

const mainColor = Color.fromARGB(255, 39, 178, 243);
const secondColor = Colors.blue;
const thirdColor = Color.fromARGB(255, 45, 130, 199);
