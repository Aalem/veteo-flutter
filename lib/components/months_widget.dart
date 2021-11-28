import 'package:flutter/cupertino.dart';
import 'package:veteo_graph/constants.dart';
import 'package:veteo_graph/helper.dart';
import 'package:veteo_graph/models/weight.dart';
import 'package:veteo_graph/models/year.dart';

Map<int, Year> yearsMap = {};

class MonthWidget extends StatelessWidget {
  final List<Weight> weightList;
  const MonthWidget({Key? key, required this.weightList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> monthNameList = [];
    for (var weight in weightList) {
      int year = getYear(weight.date);
      int month = getMonthNumber(weight.date);
      Year? yearObject = Year();
      if (!yearsMap.containsKey(year)) {
        yearObject = Year();
      } else {
        yearObject = yearsMap[year];
      }
      if (month <= 6) {
        yearObject?.shouldDrawFirstHalf = true;
      } else {
        yearObject?.shouldDrawSecondHalf = true;
      }
      yearsMap[year] = yearObject!;
    }
    yearsMap.forEach((key, value) {
      if (value.shouldDrawFirstHalf) {
        monthNameList.add(
            SizedBox(width: 6 * spaceBetweenMonths, child: Text('Jan $key')));
      }
      if (value.shouldDrawSecondHalf) {
        monthNameList.add(
            SizedBox(width: 6 * spaceBetweenMonths, child: Text('Jul $key')));
      }
    });

    return SizedBox(
      height: 28,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(children: monthNameList),
      ),
    );
  }
}
