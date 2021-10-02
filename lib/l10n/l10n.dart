
import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('gu'),
  ];

  static String getFlag(String code) {
    switch (code) {

      case 'gu':
        return 'gu';
      case 'en':
      default:
        return '🇺🇸';
    }
  }
}