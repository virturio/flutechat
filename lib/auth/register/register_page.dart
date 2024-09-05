import 'package:flutechat/auth/auth_state.dart';
import 'package:flutechat/shared/views.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      color: Colors.black54,
    );

    void loginCallback() {
      context.dispatchNotification(const AuthSettings(isRegister: false));
    }

    Widget registerButton = SubmitButton(
      submitText: "Register",
      onTap: () {},
    );

    Widget loginText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Already have an account ? | ",
          style: defaultTextStyle,
        ),
        GestureDetector(
          onTap: loginCallback,
          child: const Text(
            "login",
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
        _RegisterPageForm(),
        const SizedBox(height: 16),
        registerButton,
        const SizedBox(height: 16),
        loginText,
        const SizedBox(height: 16),
      ],
    );
  }
}

class _RegisterPageForm extends StatelessWidget {
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

    Widget confirmPasswordTextField = const MyTextField(
      hintText: "Confirm password",
      iconData: Icons.lock,
      obscureText: true,
    );

    return Column(
      children: [
        emailTextField,
        const SizedBox(height: 8),
        passwordTextField,
        const SizedBox(height: 8),
        confirmPasswordTextField,
      ],
    );
  }
}
