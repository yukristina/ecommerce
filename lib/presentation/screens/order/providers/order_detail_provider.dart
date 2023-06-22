import 'package:flutter/material.dart';

class OrderDetailProvider with ChangeNotifier {
  String? paymentMethod = 'pay-now';

  changePaymentMethod(String? value) {
    paymentMethod = value;
    notifyListeners();
  }
}
