import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:ecommerce/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

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
            const GapWidget(size: -10,),

            (provider.error != "")
                ? Text(
                    provider.error,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox(),

                const GapWidget(size: 5,),

            // email
            PrimaryTextField(
                controller: provider.emailController,
                labelText: 'Email Address'),
            const GapWidget(),

            // password
            PrimaryTextField(
              controller: provider.passwordController,
              labelText: 'Password',
              obscureText: true,
            ),

            // forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LinkButton(onPressed: () {}, text: 'Forgot Password'),
              ],
            ),
            const GapWidget(),

            // login button
            PrimaryButton(
              text: (provider.isLoading) ? "..." : 'Log In',
              onPressed: provider.logIn,
            ),

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
                LinkButton(onPressed: () {}, text: 'Sign Up'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
