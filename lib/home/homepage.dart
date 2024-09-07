import 'package:flutechat/auth/auth_service.dart';
import 'package:flutechat/chat/chat_services.dart';
import 'package:flutechat/chat/chatpage.dart';
import 'package:flutechat/shared/my_drawer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

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
        body: StreamBuilder(
            stream: _chatService.getUsersStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return const Text("Error...");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...");
              }
              final currentUser = _authService.getCurrentUser();
              final users = snapshot.data
                  ?.where((user) => user['email'] != currentUser?.email)
                  .toList();

              return ListView.separated(
                itemCount: users?.length ?? 0,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final String userEmail = users?.elementAt(index)["email"];
                  final String userId = users?.elementAt(index)["uid"];
                  return ListTile(
                    title: Text(userEmail),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChatPage(
                                    email: userEmail,
                                    id: userId,
                                  )));
                    },
                  );
                },
              );
            }));
  }
}
