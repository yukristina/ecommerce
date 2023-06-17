import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:ecommerce/presentation/widgets/primary_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Ecommerce App'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
              Text(
              'Log In',
              style: TextStyles.heading1,
            ),
            const SizedBox(
              height: 16,
            ),

            // email
            PrimaryTextField(
                controller: emailController, labelText: 'Email Address'),
            const SizedBox(
              height: 16,
            ),

            // password
            PrimaryTextField(
              controller: passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            const SizedBox(
              height: 16,
            ),

            // login button
            PrimaryButton(text: 'Log In'),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 16,
                ),

                // sign up button
                PrimaryButton(text: 'Sign Up')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
