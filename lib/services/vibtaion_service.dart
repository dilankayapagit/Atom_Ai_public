import 'dart:async';
import 'dart:io';

import 'package:vibration/vibration.dart';
import 'package:flutter/services.dart';

class VibrationService {
  static Timer? _debounceTimer;

  static void vibrate() {
    print("**************** vibrate");

    if (Platform.isIOS) {
      HapticFeedback.vibrate();
      return;
    }
    _debounceTimer?.cancel();
    // Start a new timer with the desired delay
    _debounceTimer = Timer(const Duration(milliseconds: 50), () async {
      // Perform the vibration
      await Vibration.vibrate(duration: 50);
    });
  }
}
