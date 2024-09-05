import 'package:flutechat/auth/auth_state.dart';
import 'package:flutechat/auth/login/login_page.dart';
import 'package:flutechat/auth/register/register_page.dart';
import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<AuthSettings>(
        onNotification: (notification) {
          setState(() {
            isRegister = notification.isRegister;
          });

          return true;
        },
        child: Center(
          child: Card(
              margin: const EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: isRegister ? const RegisterPage() : const LoginPage(),
              )),
        ),
      ),
    );
  }
}
