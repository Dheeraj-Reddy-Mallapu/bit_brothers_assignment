import 'dart:convert';

MyCard cardFromJson(String str) => MyCard.fromJson(json.decode(str));

String cardToJson(MyCard data) => json.encode(data.toJson());

List<MyCard> cards = [];

class MyCard {
  String name;
  String cardExpiration;
  String cardHolder;
  String cardNumber;
  String category;

  MyCard({
    required this.name,
    required this.cardExpiration,
    required this.cardHolder,
    required this.cardNumber,
    required this.category,
  });

  factory MyCard.fromJson(Map<String, dynamic> json) => MyCard(
        name: json["name"],
        cardExpiration: json["cardExpiration"],
        cardHolder: json["cardHolder"],
        cardNumber: json["cardNumber"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cardExpiration": cardExpiration,
        "cardHolder": cardHolder,
        "cardNumber": cardNumber,
        "category": category,
      };
}
