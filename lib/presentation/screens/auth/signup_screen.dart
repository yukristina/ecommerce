import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/presentation/screens/auth/providers/signup_provider.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/link_button.dart';
import '../../widgets/primary_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = "signup";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Ecommerce App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Form(
            key: provider.formkey,
            child: ListView(
              children: [
                Text(
                  'Create Account',
                  style: TextStyles.heading1,
                ),
                const GapWidget(
                  size: -10,
                ),

                (provider.error != "")
                    ? Text(
                        provider.error,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),

                const GapWidget(
                  size: 5,
                ),

                // email
                PrimaryTextField(
                    controller: provider.emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email Address is required";
                      }
                      if (!EmailValidator.validate(value.trim())) {
                        return " Invalid email address";
                      }
                      return null;
                    },
                    labelText: 'Email Address'),
                const GapWidget(),

                // password
                PrimaryTextField(
                  controller: provider.passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  labelText: 'Password',
                  obscureText: true,
                ),
                const GapWidget(),

                // confirm password
                PrimaryTextField(
                  controller: provider.cpPasswordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required";
                    } 
                    if (value.trim() !=
                        provider.passwordController.text.trim()) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  labelText: 'Confirm Password',
                  obscureText: true,
                ),
                const GapWidget(),

                // signup button
                PrimaryButton(
                  text: (provider.isLoading) ? "..." : 'Create Account',
                  onPressed: provider.createAccount,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 16,
                    ),

                    // login button
                    LinkButton(onPressed: () {}, text: 'Log In'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
