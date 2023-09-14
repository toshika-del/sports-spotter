// Strings
import 'package:flutter/material.dart';

const title = 'Sports Spotter';
const version = 'v1.0.0';

// Colors

final primaryColor = Colors.blue.shade600;
final secondaryColor = Colors.grey.shade300;
final errorColor = Colors.red.shade300;
final successColor = Colors.green.shade400;

// Paddings and Spacers

const paddingAll8 = EdgeInsets.all(8);
const paddingAll16 = EdgeInsets.all(16);
const paddingAll24 = EdgeInsets.all(24);

const space8 = SizedBox(
  height: 8,
  width: 8,
);
const space16 = SizedBox(
  height: 16,
  width: 16,
);
// Base API Url

const baseUrl = 'http://10.0.2.2:8000';
const baseUrlIOS = 'http://127.0.0.1:8000';

// functions
showSnackbar(BuildContext context, Widget content,
    [Color? background, SnackBarAction? action]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: content,
    action: action,
    backgroundColor: background,
  ));
}
