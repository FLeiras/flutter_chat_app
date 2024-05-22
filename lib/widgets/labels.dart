import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String text;
  final String subText;

  const Labels({
    super.key,
    required this.route,
    required this.text,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          subText,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
        )
      ],
    );
  }
}
