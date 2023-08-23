import 'dart:convert';
import 'package:bitbrothers_assignment/data/objects/card_object.dart';
import 'package:bitbrothers_assignment/data/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreateCardApiService {
  static const String baseUrl = 'https://interview-api.onrender.com/v1/cards';

  create(MyCard card) async {
    final Uri uri = Uri.parse(baseUrl);
    final String token = await SharedPrefs().getToken();

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(card.toJson()),
    );

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 201) {
      cards.add(card);
      return 'success';
    } else {
      return 'fail';
    }
  }
}
