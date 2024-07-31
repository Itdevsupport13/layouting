import 'package:belajar_layouting/screens/encrypt_screen.dart';
import 'package:flutter/material.dart';

class EncryptDialog extends StatelessWidget {
  const EncryptDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.enhanced_encryption),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EncryptScreen()));
        });
  }
}
