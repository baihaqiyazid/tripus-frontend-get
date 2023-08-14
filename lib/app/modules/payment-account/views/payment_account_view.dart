import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_account_controller.dart';

class PaymentAccountView extends GetView<PaymentAccountController> {
  const PaymentAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentAccountView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentAccountView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
