import 'package:flutter/material.dart';

class CancelRecordDialog extends StatefulWidget {
  const CancelRecordDialog({super.key});

  @override
  _CancelRecordDialogState createState() => _CancelRecordDialogState();
}

class _CancelRecordDialogState extends State<CancelRecordDialog> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.of(context).pop(_commentController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cancel Record'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(labelText: 'Comment'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
