import 'dart:ui';
import 'package:flutter/material.dart';

/// This attempts to intelligently cast any value to the desired type.
T intelligentCast<T>(dynamic value) {
  // already expected type, return it
  if (value is T) return value;

  // process bool here, since we need to return false rather than null
  if (T.toString() == 'bool') return boolParse(value) as T;

  // if null, dont change it.
  if (value == null) return null;

  // instead of empty string we want to return null
  if (value.toString().isEmpty) return null;

  // perform explicit parsing on the value as a string
  if (T.toString() == 'double') return double.parse(value) as T;
  if (T.toString() == 'int') return int.parse(value) as T;
  if (T.toString() == 'Color') return colorParse(value) as T;

  throw new Exception('Failed to convert $value to $T');
}

bool boolParse(String value) {
  if (value == null) return false;

  if (value.toLowerCase() == 'true') return true;
  if (value.toLowerCase() == 'false') return false;

  if (value.toLowerCase() == '1') return true;
  if (value.toLowerCase() == '0') return true;

  if (value.toLowerCase() == 'yes') return true;
  if (value.toLowerCase() == 'no') return true;

  return false;
}

Color colorParse(dynamic value) {
  // input is string (e.g. 'FF112233') convert to integer
  if (value is String) {
    if (value.toString().length == 6) value = 'FF' + value;
    value = int.parse(value, radix: 16);
  }

  // input is integer (e.g. 0xFF112233) convert to color
  if (value is int) {
    return new Color(value).withOpacity(1.0);
  }

  throw new Exception('Failed to convert $value to Color');
}

String colorToString(Color color) {
  return color.toString().split('(0x')[1].split(')')[0];
}

DateTime updateJustDate(DateTime newDate, DateTime originalDateTime) {
  return new DateTime(
    newDate.year, // year
    newDate.month, // month
    newDate.day, // day
    originalDateTime.hour, // hour
    originalDateTime.minute, // minute
    originalDateTime.second, // second
    originalDateTime.millisecond, // millisecond
    originalDateTime.microsecond, // microsecond
  );
}

DateTime updateJustTime(TimeOfDay newTime, DateTime originalDateTime) {
  return new DateTime(
    originalDateTime.year, // year
    originalDateTime.month, // month
    originalDateTime.day, // day
    newTime.hour, // hour
    newTime.minute, // minute
    0, // second
    0, // millisecond
    0, // microsecond
  );
}
