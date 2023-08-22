import 'package:bitbrothers_assignment/screens/welcome_page.dart';
import 'package:get/get.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
            home: WelcomePage());
      },
    );
  }
}
