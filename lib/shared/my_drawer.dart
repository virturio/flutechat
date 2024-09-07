import 'package:flutechat/auth/auth_service.dart';
import 'package:flutechat/home/homepage.dart';
import 'package:flutechat/settings/settings_page.dart';
import 'package:flutechat/shared/views.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    void logout() async => await _authService.logout();
    void goToHomePage() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const Homepage();
      }));
    }

    void goToSettingsPage() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const SettingsPage();
      }));
    }

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: Center(child: BrandLogo())),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListTile(
              title: const Text("H O M E"),
              leading: const Icon(Icons.home_filled),
              onTap: goToHomePage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListTile(
              title: const Text("S E T T I N G S"),
              leading: const Icon(Icons.settings),
              onTap: goToSettingsPage,
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
