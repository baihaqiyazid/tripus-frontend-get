import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/feeds_like_controller.dart';

class FeedsLikeView extends GetView<FeedsLikeController> {
  const FeedsLikeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedsLikeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FeedsLikeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
