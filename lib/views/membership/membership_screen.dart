import 'package:flutter/material.dart';
import 'package:memberlink_app/elements/app_drawer.dart';
import 'package:memberlink_app/models/user.dart';

class MembershipScreen extends StatefulWidget {
  final User user;
  const MembershipScreen({super.key, required this.user});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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
      drawer: AppDrawer(user: widget.user),
      body: const Center(
        child: Text("Membership Screen"),
      ),
    );
  }
}
