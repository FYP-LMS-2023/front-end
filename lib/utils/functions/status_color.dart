//utility function to get the color of the status
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Color status_color(status) {
  Color color = Colors.grey;
  switch (status) {
    case "Open":
      color = Colors.blue;
      break;
    case "Closed":
      color = Colors.grey;
      break;
    case "Late":
      color = Colors.red;
      break;
    case "Submitted":
      color = Colors.green;
      break;
    case "Returned":
      color = Colors.purple;
      break;
    case "Active":
      color = Colors.teal;
      break;
    case "Draft":
      color = Colors.lightBlue;
      break;
    case "Passed":
      color = Colors.green;
      break;
    case "Failed":
      color = Colors.red;
      break;
    default:
      color = Colors.grey;
  }
  return color;
}
