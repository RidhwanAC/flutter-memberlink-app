import 'package:flutter/material.dart';
import 'package:memberlink_app/elements/app_drawer.dart';
import 'package:memberlink_app/models/user.dart';

class NewsScreen extends StatefulWidget {
  final User user;
  const NewsScreen({super.key, required this.user});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "News",
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
        child: Text("News Screen"),
      ),
    );
  }
}
