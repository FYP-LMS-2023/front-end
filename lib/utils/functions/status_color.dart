//utility function to get the color of the status
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Color status_color(status) {
  status = status.toLowerCase();
  Color color = Colors.grey;
  switch (status) {
    case "open":
      color = Colors.blue;
      break;
    case "closed":
      color = Colors.grey;
      break;
    case "late":
      color = Colors.red;
      break;
    case "submitted":
      color = Colors.green;
      break;
    case "returned":
      color = Colors.purple;
      break;
    case "active":
      color = Colors.teal;
      break;
    case "draft":
      color = Colors.lightBlue;
      break;
    case "passed":
      color = Colors.green;
      break;
    case "failed":
      color = Colors.red;
      break;
    case "pending":
      color = const Color.fromARGB(255, 250, 230, 50);
      break;
    default:
      color = Colors.grey;
  }
  return color;
}
