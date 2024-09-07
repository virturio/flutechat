import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutechat/auth/auth_service.dart';
import 'package:flutechat/auth/auth_view.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key, required this.child, required this.authService});

  final Widget child;
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return child;
          } else {
            return AuthView(authService: authService);
          }
        });
  }
}
