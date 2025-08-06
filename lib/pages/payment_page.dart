import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/textfield.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String formatPhoneNumber(String number){
    number = number.trim();
    if(number.startsWith("0")){
      return number.replaceFirst("0", "254");
    } else if(number.startsWith("+254")){
      return number.replaceFirst("+", "");
    } else if(number.startsWith("254")){
      return number;
    } else{
      throw FormatException("Invalid phone number format");
    }
  }

  Future<void> initiateStkPush(BuildContext context, String phone, amount) async{
    final url = Uri.parse('https://9a5b87047261.ngrok-free.app/stk-push');
    if(phoneController.text.isNotEmpty && amountController.text.isNotEmpty){
      try{
        String formattedPhoneNumber = formatPhoneNumber(phone);
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'phone': formattedPhoneNumber,
            'amount': amount,
          }),
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("STK Push Initiated"))
          );

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("STK Push failed"))
          );
        }
      }catch (e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("something went wrong: $e"))
        );
      }
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill in all fields"))
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Textfield(text: "Phone Number  254...", controller: phoneController),
        SizedBox(height: 30,),
        Textfield(text: "Amount", controller: amountController),
        SizedBox(height: 50,),
        GestureDetector(
          onTap:() => initiateStkPush(context, phoneController.text, amountController.text),
          child: Container(
            padding: EdgeInsets.all(25),
            margin: EdgeInsets.symmetric(horizontal: 25 ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Text("PAY", style: TextStyle(color: Colors.white),),
          ),
        )
      ],
    );
  }
}
