import 'package:flutter/material.dart';
import 'package:stkpush/pages/details_page.dart';
import 'package:stkpush/pages/payment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  void navigateBottomBar(int index){
    setState(() {
      currentIndex = index;
    });
  }

  List pages = [
    PaymentPage(),
    DetailsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("STK PAYMENT")),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
          onTap: navigateBottomBar,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt),
                label: "Payments"
            ),
          ]
      ),
    );
  }
}
