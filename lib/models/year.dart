class Year {
  bool shouldDrawFirstHalf = false, shouldDrawSecondHalf = false;

  Map toJson() {
    return {
      'firstHalf': shouldDrawFirstHalf,
      'secondHalf': shouldDrawSecondHalf
    };
  }
}
