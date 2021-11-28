import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double spaceBetweenMonths = 30.5;
const double maxWeight = 24;
const double graphHeight = 180;
const String urlAllWeights = 'https://veteo.herokuapp.com/weights';
const String urlAddWeight = 'https://veteo.herokuapp.com/weights/addWeight';
List<int> listOfWeight = [12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24];

final curvePaint = Paint()
  ..color = const Color(0xFFAAD7A2)
  ..style = PaintingStyle.stroke
  ..strokeWidth = 4;
final middleLinePaint = Paint()
  ..color = const Color(0xFFAAD7A2)
  ..style = PaintingStyle.stroke
  ..strokeWidth = 3;
final verticalLinePaint = Paint()
  ..color = Colors.grey.shade100
  ..style = PaintingStyle.stroke
  ..strokeWidth = 3;
