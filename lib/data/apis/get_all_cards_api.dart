import 'dart:convert';

import 'package:bitbrothers_assignment/data/objects/card_object.dart';
import 'package:http/http.dart' as http;

class CardApiService {
  static const String baseUrl = 'https://interview-api.onrender.com/v1/cards';

  fetchListings() async {
    final Uri uri = Uri.parse(baseUrl);
    final String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2M2M2YzI5ZmFmYTVkMTAwMWRlNDkwZjYiLCJpYXQiOjE2Nzk0Mjg5MzAsImV4cCI6MzQ3OTQyODkzMCwidHlwZSI6ImFjY2VzcyJ9.3GZU2CjalRjcOHRhqm-WCvCdWaHoD5Js32VvqO2j2uY';

    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      Map responseBody = json.decode(response.body);
      List<dynamic> results = responseBody['results'];

      cards.clear();

      for (final result in results) {
        MyCard card = MyCard.fromJson(result);
        cards.add(card);
      }
    } else {
      throw Exception('Failed to load');
    }
  }
}
