class Weight {
  int weight;
  int date;

  Weight({required this.weight, required this.date});

  factory Weight.fromJson(dynamic json) {
    return Weight(weight: json['weight'], date: json['date']);
  }

  Map toJson() {
    return {'weight': weight, 'date': date, 'userId': 'u1'};
  }
}
