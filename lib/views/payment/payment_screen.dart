import 'package:flutter/material.dart';
import 'package:memberlink_app/elements/app_drawer.dart';
import 'package:memberlink_app/models/user.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  const PaymentScreen({super.key, required this.user});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF9D84FF),
      ),
      drawer: AppDrawer(user: widget.user),
      body: const Center(
        child: Text("Payment Screen"),
      ),
    );
  }
}
