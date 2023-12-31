import 'dart:convert';

import 'package:bitbrothers_assignment/data/objects/card_object.dart';
import 'package:bitbrothers_assignment/data/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CardApiService {
  static const String baseUrl = 'https://interview-api.onrender.com/v1/cards';

  fetchCards() async {
    final Uri uri = Uri.parse(baseUrl);
    final String token = await SharedPrefs().getToken();

    print("token: $token");

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // print(response.statusCode);

    if (response.statusCode == 200) {
      // print(response.body);
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
