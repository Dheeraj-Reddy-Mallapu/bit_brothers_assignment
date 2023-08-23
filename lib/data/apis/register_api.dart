import 'dart:convert';
import 'package:bitbrothers_assignment/data/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterApiService {
  static const String baseUrl = 'https://interview-api.onrender.com/v1/auth/register';

  Future<String> performRegistration(String name, String email, String password) async {
    final Uri uri = Uri.parse(baseUrl);

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      Map responseBody = json.decode(response.body);
      String token = responseBody['tokens']['access']['token'];
      await SharedPrefs().saveToken(token);
      return token;
    } else {
      return '';
    }
  }
}
