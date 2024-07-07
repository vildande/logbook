import 'package:flutter/material.dart';

class ConfirmEndDialog extends StatelessWidget {
  const ConfirmEndDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('End Incubation'),
      content: const Text('Are you sure you want to end this incubation?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
