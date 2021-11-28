import 'package:veteo_graph/constants.dart';
import 'package:veteo_graph/models/weight.dart';

// Return month name based on the
String getMonthName(int monthNumber) {
  List<String> month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  return month[monthNumber];
}

// Get number of the month from a timestamp
int getMonthNumber(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp).month;
}

// Calculate and return width of the graph
double getGraphWidth(List<Weight> weightList) {
  double numberOfMonths = 0;
  if (weightList.isNotEmpty) {
    numberOfMonths = getNumberOfMonths(weightList);
    double additionalWidth = 0;
    return numberOfMonths * spaceBetweenMonths + additionalWidth;
  }
  return 0;
}

// Get total number of months in the list
double getNumberOfMonths(List<Weight> weightList) {
  if (weightList.isNotEmpty) {
    return (DateTime.fromMillisecondsSinceEpoch(weightList[0].date)
                .difference(DateTime.fromMillisecondsSinceEpoch(
                    weightList[weightList.length - 1].date))
                .inDays)
            .abs() /
        30;
  }
  return 0;
}

// Get total number of months for specific dates
double getNumberOfMonthsForSpecificDates(int dateOne, int dateTwo) {
  return (DateTime.fromMillisecondsSinceEpoch(dateOne)
              .difference(DateTime.fromMillisecondsSinceEpoch(dateTwo))
              .inDays)
          .abs() /
      30;
}

// Get year for a date
int getYear(int date) {
  return DateTime.fromMillisecondsSinceEpoch(date).year;
}

// Get day of a date
int getDay(int date) {
  return DateTime.fromMillisecondsSinceEpoch(date).day;
}
