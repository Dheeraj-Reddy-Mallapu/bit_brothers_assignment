import 'dart:convert';
import 'package:bitbrothers_assignment/data/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginApiService {
  static const String baseUrl = 'https://interview-api.onrender.com/v1/auth/login';

  performLogin(String email, String password) async {
    final Uri uri = Uri.parse(baseUrl);

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"email": email, "password": password}),
    );

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      Map responseBody = json.decode(response.body);
      String token = responseBody['tokens']['access']['token'];
      await SharedPrefs().saveToken(token);
      return token;
    } else {
      return '';
    }
  }
}
