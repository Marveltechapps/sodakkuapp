import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const platform = MethodChannel('app.channel.shared.data');

Future<void> moveAppToBackground() async {
  try {
    await platform.invokeMethod('moveToBackground');
  } on PlatformException catch (e) {
    debugPrint("Failed to move to background: ${e.message}");
  }
}
