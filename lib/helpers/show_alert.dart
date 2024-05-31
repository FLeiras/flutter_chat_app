import 'package:flutter/material.dart';

showAlert(BuildContext context, String title, String subtitle) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          elevation: 5,
          textColor: Colors.blue[400],
          child: const Text('Ok'),
        )
      ],
    ),
  );
}
