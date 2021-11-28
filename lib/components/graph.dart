import 'package:flutter/cupertino.dart';
import 'package:veteo_graph/components/months_widget.dart';
import 'package:veteo_graph/constants.dart';
import 'package:veteo_graph/helper.dart';
import 'package:veteo_graph/models/weight.dart';

class Graph extends CustomPainter {
  int numberOfMonths = 0;
  List<Weight> weightList = [];
  Graph({required this.numberOfMonths, required this.weightList});

  final path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    // Drawing the vertical lines
    int monthVLineStartX = 0;
    int additionalLinesToCreate = getNumberOfMonths(weightList) < 12 ? 5 : 0;
    yearsMap.forEach((key, value) {
      int i = 1;
      while (i <=
          (value.shouldDrawFirstHalf && value.shouldDrawSecondHalf ? 12 : 6) +
              additionalLinesToCreate) {
        canvas.drawLine(
            Offset(monthVLineStartX * spaceBetweenMonths, 0),
            Offset(monthVLineStartX * spaceBetweenMonths, size.height),
            verticalLinePaint);
        i++;
        monthVLineStartX++;
      }
    });

    // Drawing the horizontal dashed line
    double dashHeight = 10, dashSpace = 4, dashedLineStartX = 0;
    while (dashedLineStartX < (monthVLineStartX * spaceBetweenMonths)) {
      canvas.drawLine(
          Offset(dashedLineStartX, size.height / 2),
          Offset(dashedLineStartX + dashHeight, size.height / 2),
          middleLinePaint);
      dashedLineStartX += dashHeight + dashSpace;
    }

    double curveStartX = 0;
    if (weightList.isNotEmpty) {
      int firstMonthNumber = getMonthNumber(weightList.first.date);
      double reducedPixelsForDays = 30.5 - getDay(weightList.first.date);

      if (firstMonthNumber <= 6) {
        curveStartX =
            firstMonthNumber * spaceBetweenMonths - reducedPixelsForDays;
      } else {
        curveStartX =
            (firstMonthNumber - 6) * spaceBetweenMonths - reducedPixelsForDays;
      }
      print('curvedStartX $curveStartX');
      path.moveTo(curveStartX, (maxWeight - weightList.first.weight) * 15);
    }

    // Drawing curves and circles
    for (var i = 0; i < weightList.length; i++) {
      if (i == weightList.length - 1) break;
      double y1 = (maxWeight - weightList[i].weight) * 15;
      double y2 = (maxWeight - weightList[i + 1].weight) * 15;
      int x2 = DateTime.fromMillisecondsSinceEpoch(weightList[i + 1].date)
          .difference(DateTime.fromMillisecondsSinceEpoch(weightList[i].date))
          .inDays;
      if (i != 0) path.addOval(Rect.fromLTWH(curveStartX - 2, y1 - 6, 12, 12));
      path.quadraticBezierTo(curveStartX + 8, y1, curveStartX + x2 - 2, y2);
      curveStartX += x2;
      if (i + 1 == weightList.length - 1) {
        path.addOval(Rect.fromLTWH(curveStartX - 2, y2 - 6, 12, 12));
      }
    }
    canvas.drawPath(path, curvePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
