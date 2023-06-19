import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/logic/cubits/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_state.dart';
import 'package:ecommerce/presentation/screens/auth/providers/login_provider.dart';
import 'package:ecommerce/presentation/screens/auth/signup_screen.dart';
import 'package:ecommerce/presentation/screens/home/home_screen.dart';
import 'package:ecommerce/presentation/screens/splash/splash_screen.dart';
import 'package:ecommerce/presentation/widgets/gap_widget.dart';
import 'package:ecommerce/presentation/widgets/link_button.dart';
import 'package:ecommerce/presentation/widgets/primary_button.dart';
import 'package:ecommerce/presentation/widgets/primary_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
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
                    'Log In',
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
                      LinkButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SignUpScreen.routeName);
                          },
                          text: 'Sign Up'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
