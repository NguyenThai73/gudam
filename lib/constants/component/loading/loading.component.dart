import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
        child: const Center(child: CircularProgressIndicator(color: Colors.blue,)));
  }
}
