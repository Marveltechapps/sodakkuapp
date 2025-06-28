import 'package:flutter/material.dart';

class CartSectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const CartSectionContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 19, vertical: 15),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}
