import 'package:flutechat/auth/auth_service.dart';
import 'package:flutechat/auth/auth_settings.dart';
import 'package:flutechat/shared/views.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.authService});
  final AuthService authService;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      color: Colors.black54,
    );

    void reqisterCallback() {
      context.dispatchNotification(const AuthSettings(isRegister: true));
    }

    Future<void> showErrorDialog(Object e) async {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
                title: Text(e.toString()),
              ));
    }

    void loginCallback() async {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      try {
        await widget.authService.loginWithEmailAndPassword(
          email: email,
          password: password,
        );
      } catch (e) {
        await showErrorDialog(e);
      }
    }

    Widget loginButton = SubmitButton(
      submitText: "Login",
      onTap: loginCallback,
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
        _LoginPageForm(
          emailController: _emailController,
          passwordController: _passwordController,
        ),
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
  const _LoginPageForm(
      {required this.emailController, required this.passwordController});

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    Widget emailTextField = MyTextField(
      hintText: "Email",
      iconData: Icons.email,
      controller: emailController,
    );

    Widget passwordTextField = MyTextField(
      hintText: "Password",
      iconData: Icons.lock,
      obscureText: true,
      controller: passwordController,
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
