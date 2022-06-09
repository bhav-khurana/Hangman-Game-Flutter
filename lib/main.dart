import 'package:flutter/material.dart';
import 'package:mr_hangman/pages/demo.dart';
import 'package:mr_hangman/pages/difficulty.dart';
import 'package:mr_hangman/pages/gameplay.dart';
import 'package:mr_hangman/pages/home.dart';
import 'package:mr_hangman/pages/instructions.dart';
import 'package:mr_hangman/pages/loading.dart';

void main() {
  runApp(MaterialApp(
        theme: ThemeData(fontFamily: 'Ubuntu'),
        initialRoute: '/home',
        routes: {
          '/home': (context) => Home(),
          '/gameplay': (context) => Gameplay(),
          '/instructions': (context) => Instructions(),
          '/difficulty': (context) => Difficulty(),
          '/demo': (context) => Demo(),
          '/loading': (context) => Loading()
        }
    ),
  );
}