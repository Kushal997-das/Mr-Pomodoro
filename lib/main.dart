import 'package:flutter/material.dart';
import 'package:hello_promodoro/FrontEnd/welcomeScreen.dart';
import 'package:hello_promodoro/FrontEnd/Main_Screen.dart';
import 'package:hello_promodoro/FrontEnd/pomodoro_clock.dart';
import 'package:hello_promodoro/FrontEnd/Sign_up.dart';
import 'package:hello_promodoro/FrontEnd/pointsAndLevelsShow.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Mr. PromoDoro",
    home: Hello(),
  ));
}
