import 'package:flutter/material.dart';
import 'package:memberlink_app/elements/app_drawer.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Membership",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF9D84FF),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text("Membership Screen"),
      ),
    );
  }
}
