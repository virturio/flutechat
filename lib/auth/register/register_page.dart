import 'package:flutechat/auth/auth_service.dart';
import 'package:flutechat/auth/auth_state.dart';
import 'package:flutechat/shared/views.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.authService});
  final AuthService authService;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      color: Colors.black54,
    );

    void loginCallback() {
      context.dispatchNotification(const AuthSettings(isRegister: false));
    }

    void registerCallback() async {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String confirmPassword = _confirmPasswordController.text;
      await widget.authService.register(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
    }

    Widget registerButton = SubmitButton(
      submitText: "Register",
      onTap: registerCallback,
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
        _RegisterPageForm(
          emailController: _emailController,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
        ),
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
  const _RegisterPageForm({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

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

    Widget confirmPasswordTextField = MyTextField(
      hintText: "Confirm password",
      iconData: Icons.lock,
      obscureText: true,
      controller: confirmPasswordController,
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
