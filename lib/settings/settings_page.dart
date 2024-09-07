import 'package:flutechat/shared/my_drawer.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      drawer: const MyDrawer(),
      body: Container(
        child: const Center(
          child: Text("Settings"),
        ),
      ),
    );
  }
}
