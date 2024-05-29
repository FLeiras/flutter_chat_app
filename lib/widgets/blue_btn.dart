import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPress;

  const BlueButton({
    super.key,
    required this.btnText,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(2),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: onPress,
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
