import 'package:bitbrothers_assignment/screens/login_page.dart';
import 'package:bitbrothers_assignment/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return OnBoardingSlider(
      headerBackgroundColor: isLightMode ? Colors.white : Colors.black,
      finishButtonText: 'Register',
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Colors.black,
      ),
      onFinish: () => Get.offAll(() => RegisterPage()),
      skipTextButton: Text('Skip'),
      trailing: Text('Login'),
      trailingFunction: () => Get.offAll(() => LoginPage()),
      background: [
        Image.asset(
          'assets/images/slide_1.png',
          width: MediaQuery.of(context).size.width,
          height: 500,
        ),
        Image.asset(
          'assets/images/slide_2.png',
          width: MediaQuery.of(context).size.width,
          height: 500,
        ),
        Image.asset(
          'assets/images/slide_3.png',
          width: MediaQuery.of(context).size.width,
          height: 500,
        ),
      ],
      totalPage: 3,
      speed: 1.8,
      pageBodies: [
        PageBody('Welcome'),
        PageBody('Save your cards virtually'),
        PageBody('Safe and Secure'),
      ],
    );
  }

  Widget PageBody(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 500,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
