import 'package:flutter/material.dart';

class CustomStyles {
  static const TextStyle small = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.9,
    color: Colors.black
  );

  static const TextStyle extraSmall = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.9,
    color: Colors.black,
  );

  static const TextStyle medium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.9,
    color: Colors.black,
    textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle large = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    color: Colors.black,
  );
}