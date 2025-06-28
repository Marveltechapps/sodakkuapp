import 'package:flutter/material.dart';
import 'package:sodakkuapp/apiservice/secure_storage/secure_storage.dart';
import 'package:sodakkuapp/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearAllData() async {
  final prefs = await SharedPreferences.getInstance();
  await TokenService.deleteToken();
  await prefs.clear();
}

void showLogOutDialog(BuildContext context) {
  showDialog(
    context: context,
    //  barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: whitecolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              //   Image.asset(successImage),
              SizedBox(height: 16),
              // Success Message
              Text(
                "Oh No! You're leaving....",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Are you sure?",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: appColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                  clearAllData();
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: whitecolor,
                    border: Border.all(width: 1, color: appColor),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      "yes, Log out",
                      style: TextStyle(fontSize: 16, color: appColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
