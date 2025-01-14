import 'package:flutter/material.dart';
import 'package:project_coffe_shop/features/login/login_screen.dart';

void main() {
  runApp(const RFCoffeeShop());
}

class RFCoffeeShop extends StatelessWidget {
  const RFCoffeeShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shop POS',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.brown.shade50,
      ),
      home: const LoginScreen(),
    );
  }
}
