import 'package:flutter/services.dart';

class LowerCase extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toLowerCase());
  }
}

class UppCase extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class TimeText extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final formattedText = _formatTime(text);
    return newValue.copyWith(text: formattedText);
  }

  String _formatTime(String input) {
    // Assuming input is in the format hh:mm
    final parts = input.split(':');
    final hours = parts.length > 0 ? parts[0] : '';
    final minutes = parts.length > 1 ? parts[1] : '';

    // Ensure leading zeroes
    final formattedHours = hours.padLeft(2, '0');
    final formattedMinutes = minutes.padLeft(2, '0');

    return '$formattedHours:$formattedMinutes';
  }
}
