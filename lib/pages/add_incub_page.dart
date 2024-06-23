import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddIncubPage extends StatefulWidget {
  const AddIncubPage({super.key});

  @override
  State<AddIncubPage> createState() => _AddIncubPageState();
}

class _AddIncubPageState extends State<AddIncubPage> {
  bool _topIncubUsed = false;
  bool _bottomIncubUsed = false;

  final _contactNameController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _usageController = TextEditingController();

  @override
  void dispose() {
    _contactNameController.dispose();
    _contactPhoneController.dispose();
    _usageController.dispose();
    super.dispose();
  }

  void _toggleTopIncub(bool? value) {
    setState(() {
      _topIncubUsed = value ?? false;
    });
  }

  void _toggleBottomIncub(bool? value) {
    setState(() {
      _bottomIncubUsed = value ?? false;
    });
  }

  Future<void> _startIncubation() async {
    String contactName = _contactNameController.text;
    String contactPhone = _contactPhoneController.text;
    String usageDetails = _usageController.text;

    if (!_validateInputs(contactName, contactPhone, usageDetails)) {
      return;
    }

    DateTime timeNow = DateTime.now();

    List<Map<String, dynamic>> incubationRecords = [];

    if (_topIncubUsed) {
      incubationRecords.add({
        'name': contactName,
        'phone': contactPhone,
        'usage': usageDetails,
        'type': 'Top',
        'start': timeNow.toIso8601String()
      });
    }
    if (_bottomIncubUsed) {
      incubationRecords.add({
        'name': contactName,
        'phone': contactPhone,
        'usage': usageDetails,
        'type': 'Bottom',
        'start': timeNow.toIso8601String()
      });
    }

    for (var record in incubationRecords) {
      var response = await _sendIncubationData(record);
      if (!response) {
        _showPopupMessage("Something went wrong, please try again.");
        return;
      }
    }

    _showPopupMessage("Congratulations, incubation started successfully!", success: true);
  }

  bool _validateInputs(String name, String phone, String usageDetails) {
    if (name.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      _showPopupMessage("Please enter a valid name.");
      return false;
    }
    if (phone.isEmpty || !RegExp(r'^\+?[0-9 ]+$').hasMatch(phone)) {
      _showPopupMessage("Please enter a valid phone number.");
      return false;
    }
    if (!_topIncubUsed && !_bottomIncubUsed) {
      _showPopupMessage("Please select at least one incubator type.");
      return false;
    }
    if (usageDetails.length < 10) {
      _showPopupMessage("Usage description must be at least 10 characters long.");
      return false;
    }
    return true;
  }

  Future<bool> _sendIncubationData(Map<String, dynamic> data) async {
    final url = Uri.parse('http://your-flask-api-url.com/incubation');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void _showPopupMessage(String message, {bool success = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(success ? "Success" : "Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (success) {
                  Navigator.of(context).pop();
                }
              },
              child: Text(success ? "OK" : "Try Again"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Incubation Record"),
        backgroundColor: const Color.fromRGBO(31, 38, 51, 1),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromRGBO(31, 38, 51, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            _buildContactNameSection(),
            _buildContactPhoneSection(),
            _buildIncubatorSelectionSection(),
            _buildUsageDescriptionSection(),
            _buildStartIncubationButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactNameSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Name", style: TextStyle(color: Colors.white, fontSize: 24)),
          const SizedBox(height: 10),
          _buildTextInputField(controller: _contactNameController, hintText: "John Doe"),
        ],
      ),
    );
  }

  Widget _buildContactPhoneSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Phone number", style: TextStyle(color: Colors.white, fontSize: 24)),
          const SizedBox(height: 10),
          _buildTextInputField(controller: _contactPhoneController, hintText: "+7 777 777 77 77"),
        ],
      ),
    );
  }

  Widget _buildIncubatorSelectionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Which Incubator(s)?", style: TextStyle(color: Colors.white, fontSize: 24)),
          Row(
            children: [
              Checkbox(value: _topIncubUsed, onChanged: _toggleTopIncub),
              const Text("Top", style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
          Row(
            children: [
              Checkbox(value: _bottomIncubUsed, onChanged: _toggleBottomIncub),
              const Text("Bottom", style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsageDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Usage Description", style: TextStyle(color: Colors.white, fontSize: 24)),
          const Text("(quantity and type of tubes / content / temperature / rpm)", style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 10),
          _buildTextInputField(
            controller: _usageController,
            hintText: 'Usage description',
            maxLines: 5,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }

  Widget _buildTextInputField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText, border: InputBorder.none),
        maxLines: maxLines,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildStartIncubationButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: _startIncubation,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        ),
        child: const Text(
          "Start Incubation",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
