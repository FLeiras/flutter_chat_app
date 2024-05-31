import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String btnText;
  final Color color;
  final Function()? onPressed;

  const BlueButton({
    super.key,
    required this.btnText,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(2),
        backgroundColor: WidgetStateProperty.all<Color>(color),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            btnText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
