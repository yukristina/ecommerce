import 'package:ecommerce/core/routes.dart';
import 'package:ecommerce/core/ui.dart';
import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: LoginScreen.routeName,
      title: 'Flutter Demo',
      theme: Themes.defaultTheme,
      home: const Text('Flutter Demo Home Page'),
    );
  }
}
