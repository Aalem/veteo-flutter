import 'dart:convert';
import 'dart:io';

import 'package:veteo_graph/constants.dart';
import 'package:veteo_graph/models/weight.dart';

class VeteoAPI {
  List<Weight> weightListFromAPI = [];

  Future<List<Weight>> getAllWeights() async {
    var request = await HttpClient().getUrl(Uri.parse(urlAllWeights));
    var response = await request.close();

    await for (var contents in response.transform(Utf8Decoder())) {
      var data = json.decode(contents);
      for (var d in data) {
        weightListFromAPI.add(Weight.fromJson(d));
      }
    }
    return weightListFromAPI;
  }

  void addWeight(Weight weight) async {
    var request = await HttpClient().postUrl(Uri.parse(urlAddWeight));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    request.write(jsonEncode(weight.toJson()));

    final response = await request.close();

    response.transform(utf8.decoder).listen((contents) {});
  }
}
