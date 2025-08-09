import 'package:flutter/material.dart';
import 'package:sodakkuapp/utils/constant.dart';

void showSuccessDialog(
  bool isSuccess,
  String content,
  String? address,
  String locationType,
  String screenType,
  BuildContext context,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Image.asset(successImage),
              SizedBox(height: 16),
              // Success Message
              Text(
                isSuccess ? "Successful!" : "Failure",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),
              // Done Button
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    //  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    if (screenType == "address") {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                      Navigator.pop(context, "");
                    } else if (screenType == "") {
                      Navigator.of(context).pop();
                      Navigator.pop(context, "success");
                    } else if (screenType == "delete") {
                      Navigator.pop(context);
                    } else if (screenType == "save") {
                      Navigator.of(context).pop();
                    } else if (screenType == "editaddress") {
                      Navigator.of(context).pop();
                      Navigator.pop(context, "success");
                    } else if (screenType == "change") {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                      Navigator.pop(context, "success");
                    } /* else if (screenType == "screen") {
                      Navigator.of(context).pop();
                      Navigator.pop(context, "success");
                    } */ else {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.pop(context);
                      Navigator.pop(context, [address, locationType]);
                    }
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
