import 'package:flutter/material.dart';

Color mC = Color(0xffDDDDDD);
Color mW = Colors.white54;
Color mB = Colors.black.withOpacity(0.075);
Color mG = Colors.green.withOpacity(0.65);
Color mR = Colors.grey.shade600;

BoxDecoration nMbox = BoxDecoration(
    shape: BoxShape.circle,
    color: Color.fromRGBO(236, 240, 243, 100),
    boxShadow: [
      BoxShadow(
        color: mB,
        offset: Offset(5, 5),
        blurRadius: 5,
      ),
      BoxShadow(
        color: mW,
        offset: Offset(-5, -5),
        blurRadius: 5,
      )
    ]);

BoxDecoration nMboxInvert = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: mB,
    boxShadow: [
      BoxShadow(
        color: mW,
        offset: Offset(3, 3),
        blurRadius: 3,
        spreadRadius: -3,
      )
    ]);
