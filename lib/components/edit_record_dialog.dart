import 'package:flutter/material.dart';
import '../models/user_model.dart';

class EditRecordDialog extends StatefulWidget {
  final User user;

  const EditRecordDialog({super.key, required this.user});

  @override
  _EditRecordDialogState createState() => _EditRecordDialogState();
}

class _EditRecordDialogState extends State<EditRecordDialog> {
  final _contactNameController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _usageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contactNameController.text = widget.user.name;
    _contactPhoneController.text = widget.user.phoneNumber;
    _usageController.text = widget.user.usageDetails;
  }

  @override
  void dispose() {
    _contactNameController.dispose();
    _contactPhoneController.dispose();
    _usageController.dispose();
    super.dispose();
  }

  void _submit() {
    final updatedUser = widget.user.copyWith(
      name: _contactNameController.text,
      phoneNumber: _contactPhoneController.text,
      usageDetails: _usageController.text,
    );
    Navigator.of(context).pop(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Record'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _contactNameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _contactPhoneController,
            decoration: const InputDecoration(labelText: 'Phone Number'),
          ),
          TextField(
            controller: _usageController,
            decoration: const InputDecoration(labelText: 'Usage Details'),
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
          child: const Text('Save'),
        ),
      ],
    );
  }
}
