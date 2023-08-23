import 'package:bitbrothers_assignment/data/shared_preferences.dart';
import 'package:bitbrothers_assignment/screens/credit_cards_page.dart';
import 'package:bitbrothers_assignment/screens/welcome_page.dart';
import 'package:get/get.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true; // to wait till the token is loaded
  bool isUserLoggedIn = false;

  loadToken() async {
    String token = await SharedPrefs().getToken();
    // print(token);
    if (token != '') {
      isLoading = false;
      isUserLoggedIn = true;
      setState(() {});
    } else {
      isLoading = false;
      isUserLoggedIn = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    loadToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return GetMaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightDynamic,
              fontFamily: 'Lato',
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkDynamic,
              fontFamily: 'Lato',
            ),
            title: 'Bit Brothers Assignment by Dheeraj',
            debugShowCheckedModeBanner: false,
            home: isLoading
                ? Center(child: CircularProgressIndicator())
                : isUserLoggedIn
                    ? CreditCardsPage()
                    : WelcomePage());
      },
    );
  }
}
