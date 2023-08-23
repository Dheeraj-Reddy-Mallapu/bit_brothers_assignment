import 'package:bitbrothers_assignment/data/apis/get_all_cards_api.dart';
import 'package:bitbrothers_assignment/data/objects/card_object.dart';
import 'package:bitbrothers_assignment/data/shared_preferences.dart';
import 'package:bitbrothers_assignment/screens/add_card_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

import 'welcome_page.dart';

class CreditCardsPage extends StatefulWidget {
  @override
  State<CreditCardsPage> createState() => _CreditCardsPageState();
}

class _CreditCardsPageState extends State<CreditCardsPage> {
  bool isLoading = true;
  fetchData() async {
    await SharedPrefs().getToken();
    await CardApiService().fetchCards();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitleSection(title: "Payment Details", subTitle: "How would you like to pay ?"),
              Expanded(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: cards.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final card = cards[index];
                            return index != cards.length - 1
                                ? Align(
                                    heightFactor: 0.20,
                                    alignment: Alignment.topCenter,
                                    child: _buildCreditCard(
                                      color: Color((math.Random().nextDouble() * 0xFF250000).toInt()).withOpacity(1.0),
                                      cardNumber: card.cardNumber,
                                      cardHolder: card.cardHolder,
                                      cardExpiration: card.cardExpiration,
                                      category: card.category,
                                    ),
                                  )
                                : _buildCreditCard(
                                    color: Color(0xFF250000),
                                    cardNumber: card.cardNumber,
                                    cardHolder: card.cardHolder,
                                    cardExpiration: card.cardExpiration,
                                    category: card.category,
                                  );
                          },
                        )),
              _buildAddCardButton(
                icon: Icon(Icons.add),
                // color: Color(0xFF081603),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Build the title section
  _buildTitleSection({@required title, @required subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 16.0),
              child: Text(
                '$title',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
              child: Text(
                '$subTitle',
                style: TextStyle(fontSize: 21, color: Colors.blueGrey),
              ),
            )
          ],
        ),
        TextButton(
            onPressed: () {
              SharedPrefs().saveToken('');
              Get.offAll(() => WelcomePage());
            },
            child: Text('Logout'))
      ],
    );
  }

  // Build the credit card widget
  Card _buildCreditCard({
    required Color color,
    required String cardNumber,
    required String cardHolder,
    required String cardExpiration,
    required String category,
  }) {
    return Card(
      color: color,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: MediaQuery.of(context).size.width * .56, // card ratio = 85.60/53.98
        width: MediaQuery.of(context).size.width * .9,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(category),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(color: Colors.white, fontSize: 21, fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock(String category) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
        Image.asset(
          category == 'MC' ? "assets/images/mastercard.png" : "assets/images/visa.png",
          height: 50,
          width: 50,
        ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

// Build the FloatingActionButton
  Container _buildAddCardButton({
    required Icon icon,
    // required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          Get.to(() => AddCardPage());
        },
        // backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }
}
