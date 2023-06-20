import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      fit: BoxFit.fill,
      child: Center(
        child: Icon(IconlyBold.tick_square),
      ),
    );
  }
}
