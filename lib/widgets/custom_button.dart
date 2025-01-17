import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onButtonPressed;
  final String text;
  const CustomButton({
    super.key,
    required this.onButtonPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(249, 113, 152, 220),
              minimumSize: const Size(400, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: onButtonPressed,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              fontFamily: 'Jaldi',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
