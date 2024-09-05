import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.iconData,
      this.obscureText = false});

  final IconData iconData;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = InputDecoration(
      border: InputBorder.none,
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.black54,
      ),
      filled: true,
      fillColor: Colors.white,
      prefixIconConstraints: const BoxConstraints(),
      contentPadding: const EdgeInsets.all(20),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          iconData,
          color: Colors.black45,
        ),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: TextField(
        decoration: decoration,
        obscureText: obscureText,
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {super.key, required this.submitText, required this.onTap});

  final String submitText;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          submitText,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 70,
      height: 70,
      child: FittedBox(
          child: Icon(
        Icons.message_rounded,
        color: Colors.black45,
      )),
    );
  }
}
