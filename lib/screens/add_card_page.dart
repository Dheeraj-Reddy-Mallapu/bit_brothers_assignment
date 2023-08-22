import 'package:bitbrothers_assignment/data/objects/card_object.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  CardDetails? cardDetails;
  final formKey = GlobalKey<FormState>();

  TextEditingController nameC = TextEditingController();
  TextEditingController cardExpirationC = TextEditingController();
  TextEditingController cardHolderC = TextEditingController();
  TextEditingController cardNumberC = TextEditingController();
  TextEditingController categoryC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    cardDetails = await CardScanner.scanCard(
                        scanOptions: CardScanOptions(
                      scanCardHolderName: true,
                      scanExpiryDate: true,
                    ));

                    cardHolderC.text = cardDetails!.cardHolderName;
                    cardExpirationC.text = cardDetails!.expiryDate;
                    cardNumberC.text = cardDetails!.cardNumber;
                    categoryC.text = cardDetails!.cardIssuer;
                  },
                  icon: Icon(Icons.qr_code_scanner),
                  label: Text('Scan'),
                ),
              ),
              _buildTextFormField(nameC, 'Name'),
              _buildTextFormField(cardHolderC, 'Name on Card'),
              _buildTextFormField(cardNumberC, 'Number'),
              _buildTextFormField(cardExpirationC, 'Expiry Date (MM/YYYY)'),
              _buildTextFormField(categoryC, 'Issuer (eg. VISA)'),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final card = MyCard(
                      name: nameC.text,
                      cardExpiration: cardExpirationC.text,
                      cardHolder: cardHolderC.text,
                      cardNumber: cardNumberC.text,
                      category: categoryC.text,
                    );

                    Get.back();
                  }
                },
                child: Text('Add Card'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill in the details';
          }
          return null;
        },
      ),
    );
  }
}
