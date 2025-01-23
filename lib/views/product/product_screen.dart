import 'package:flutter/material.dart';
import 'package:memberlink_app/elements/app_drawer.dart';
import 'package:memberlink_app/models/user.dart';

class ProductScreen extends StatefulWidget {
  final User user;
  const ProductScreen({super.key, required this.user});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Products",
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
        child: Text("Products Screen"),
      ),
    );
  }
}
