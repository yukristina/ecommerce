import 'dart:async';

import 'package:ecommerce/logic/cubits/user_cubit.dart';
import 'package:ecommerce/logic/cubits/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpProvider with ChangeNotifier {
  final BuildContext context;
  SignUpProvider(this.context) {
    _listenToUserCubit();
  }
  bool isLoading = false;
  String error = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpPasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    _userSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if (userState is UserLoadingState) {
        isLoading = true;
        error = '';
        notifyListeners();
      } else if (userState is UserErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      } else {
        isLoading = false;
        error = '';
        notifyListeners();
      }
    });
  }

  void createAccount() async {
    if (!formkey.currentState!.validate()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    BlocProvider.of<UserCubit>(context)
        .createAccount(email: email, password: password);
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
