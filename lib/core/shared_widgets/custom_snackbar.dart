import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning }

void customSnackbar({
  required BuildContext context,
  required String message,
  SnackbarType type = SnackbarType.success,
  Duration duration = const Duration(seconds: 3),
}) {
  // Define color and icon based on type
  Color backgroundColor;
  IconData icon;

  switch (type) {
    case SnackbarType.success:
      backgroundColor = Colors.green;
      icon = Icons.check_circle;
      break;
    case SnackbarType.error:
      backgroundColor = Colors.red;
      icon = Icons.error;
      break;
    case SnackbarType.warning:
      backgroundColor = Colors.orange;
      icon = Icons.warning;
      break;
  }

  final snackBar = SnackBar(
    duration: duration,
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    content: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
