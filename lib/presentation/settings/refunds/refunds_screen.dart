import 'package:flutter/material.dart';
import 'package:sodakkuapp/utils/constant.dart';

class RefundsScreen extends StatelessWidget {
  const RefundsScreen({super.key});

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
        title: Text("Refunds", style: TextStyle(color: headerComponentsColor)),
      ),
      body: Center(
        child: Column(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Refunds", style: Theme.of(context).textTheme.displayMedium),
            Text(
              "You have  no active or past refunds.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
