import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  final Color? color;

  final CrossAxisAlignment alignment;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.color,
      required this.alignment});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2;
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width),
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message,
          ),
        ),
      ],
    );
  }
}
