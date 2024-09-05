import 'package:flutechat/auth/auth_state.dart';
import 'package:flutechat/shared/views.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      color: Colors.black54,
    );

    void reqisterCallback() {
      context.dispatchNotification(const AuthSettings(isRegister: true));
    }

    Widget loginButton = SubmitButton(
      submitText: "Login",
      onTap: () {},
    );

    Widget forgotPasswordText = const Align(
      alignment: Alignment.centerRight,
      child: Text(
        "Forgot password ?",
        textAlign: TextAlign.end,
        style: defaultTextStyle,
      ),
    );

    Widget registerText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Does'nt have an account ? | ",
          style: defaultTextStyle,
        ),
        GestureDetector(
          onTap: reqisterCallback,
          child: const Text(
            "register",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const BrandLogo(),
        const SizedBox(height: 32),
        _LoginPageForm(),
        const SizedBox(height: 8),
        forgotPasswordText,
        const SizedBox(height: 16),
        loginButton,
        const SizedBox(height: 16),
        registerText,
        const SizedBox(height: 16),
      ],
    );
  }
}

class _LoginPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget emailTextField = const MyTextField(
      hintText: "Email",
      iconData: Icons.email,
    );

    Widget passwordTextField = const MyTextField(
      hintText: "Password",
      iconData: Icons.lock,
      obscureText: true,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        emailTextField,
        const SizedBox(height: 8),
        passwordTextField,
      ],
    );
  }
}
