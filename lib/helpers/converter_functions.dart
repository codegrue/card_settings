// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

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

/// This will parse various conceptual representaitons of yes/no into a boolean
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

/// This will parse either a string or integer representation of a color into an actual Color
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

/// This will convert a Color to a hex string (more abreviated than the .toString() method.
String colorToString(Color color) {
  return color.toString().split('(0x')[1].split(')')[0];
}

/// Given a DateTime this will replace just the date portion leaving the time unchanged
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

/// Given a DateTime this will replace just the time portion leaving the date unchanged
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
