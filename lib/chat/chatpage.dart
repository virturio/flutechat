import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutechat/auth/auth_service.dart';
import 'package:flutechat/chat/chat_services.dart';
import 'package:flutechat/shared/chat_buble.dart';
import 'package:flutechat/shared/views.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String email;
  final String id;

  const ChatPage({
    super.key,
    required this.email,
    required this.id,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final AuthService authService = AuthService();
  final ChatService chatService = ChatService();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.email,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(26, 8, 0, 25),
                  child: MyTextField(
                    hintText: "Masukkan pesan",
                    controller: _controller,
                  ),
                ),
              ),
              IconButton(
                iconSize: 24,
                onPressed: () {
                  chatService.sendMessage(
                      receiverId: widget.id, message: _controller.text);
                  _controller.clear();
                },
                icon: const Icon(Icons.send),
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.transparent)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildMessageList() {
    User? currentUser = authService.getCurrentUser();
    String userId = currentUser?.uid ?? "";
    String receiverId = widget.id;

    return StreamBuilder(
        stream:
            chatService.getMessages(userId: userId, otherUserId: receiverId),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Error"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading..."),
            );
          }

          final docs = snapshot.data?.docs;

          return ListView.builder(
            itemCount: docs?.length ?? 0,
            itemBuilder: (context, index) {
              final data = docs?.elementAt(index).data() ?? {};
              final isSender = data['senderId'] == userId;
              final CrossAxisAlignment textAlign =
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;

              return ChatBubble(
                color: isSender ? Colors.greenAccent : Colors.grey[300],
                message: data["message"],
                alignment: textAlign,
              );
            },
          );
        });
  }
}
