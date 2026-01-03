import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onPressed;

  const BlockButton({super.key, required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              label,
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      )
    );
  }
}