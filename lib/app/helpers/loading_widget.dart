import "package:flutter/material.dart";

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: Colors.blueAccent, backgroundColor: Colors.transparent,);
  }
}