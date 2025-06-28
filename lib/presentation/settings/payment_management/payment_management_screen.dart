import 'package:flutter/material.dart';
import 'package:sodakkuapp/utils/constant.dart';

class PaymentManagementScreen extends StatelessWidget {
  const PaymentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerColor,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: headerComponentsColor,
            size: 16,
          ),
        ),
        elevation: headerElevation,
        title: Text(
          "Payment Management",
          style: TextStyle(color: headerComponentsColor),
        ),
      ),
    );
  }
}
