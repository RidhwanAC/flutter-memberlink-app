import 'package:flutter/material.dart';
import 'package:memberlink_app/views/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../auth/register_screen.dart';
import 'package:memberlink_app/models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool rememberme = false;

  // Helper method to show SnackBar
  void _showSnackBar(String message, bool isSuccess) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF9D84FF), Color(0xFF6B4EFF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      labelText: "User name / Email",
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberme,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberme = value ?? false;
                          });
                        },
                      ),
                      const Text("Remember me"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B4EFF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LOG IN NOW",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      "New here? Sign up now",
                      style: TextStyle(
                        color: Color(0xFF6B4EFF),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      _showSnackBar('Please fill in all fields', false);
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://localhost/memberlink_app/api/login.php'),
        body: {
          'email': emailCtrl.text,
          'password': passwordCtrl.text,
        },
      );

      if (!mounted) return;

      Map<String, dynamic> responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final userData = responseData['data']['user'];
        final user = User(
          id: userData['id'].toString(),
          username: userData['username'],
          email: userData['email'],
          dateReg: userData['date_reg'] ?? '',
          profilePic:
              userData['profile_pic'] ?? 'assets/images/default_avatar.png',
        );

        await _storeUserData(user);
        if (rememberme) {
          await _storeCredentials(emailCtrl.text, passwordCtrl.text);
        } else {
          await _clearStoredCredentials();
        }

        _showSnackBar('Login successful!', true);
        await Future.delayed(const Duration(seconds: 1));

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen(user: user)),
        );
      } else {
        _showSnackBar(responseData['message'], false);
      }
    } catch (e) {
      _showSnackBar('Network error occurred', false);
    }
  }

  Future<void> _storeUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> _storeCredentials(String identifier, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final bool isEmail = identifier.contains('@');

    await prefs.setBool('rememberMe', true);

    if (isEmail) {
      await prefs.setString('email', identifier);
      await prefs.setString('password', password);
      await prefs.remove('username');
    } else {
      await prefs.setString('username', identifier);
      await prefs.setString('password', password);
      await prefs.remove('email');
    }
  }

  Future<void> _clearStoredCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.setBool('rememberMe', false);
  }

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberme = prefs.getBool('rememberMe') ?? false;
      if (rememberme) {
        emailCtrl.text =
            prefs.getString('email') ?? prefs.getString('username') ?? '';
        passwordCtrl.text = prefs.getString('password') ?? '';
      }
    });
  }
}
