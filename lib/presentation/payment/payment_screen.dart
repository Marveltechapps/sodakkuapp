import 'package:flutter/material.dart';
import 'package:sodakkuapp/utils/constant.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerColor,
        surfaceTintColor: Colors.transparent,
        title: Text('Payment', style: TextStyle(color: headerComponentsColor)),
        elevation: headerElevation,
      ),
    );
  }
}
