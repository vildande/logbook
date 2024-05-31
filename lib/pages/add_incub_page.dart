import 'package:flutter/material.dart';

class AddIncubPage extends StatefulWidget {
  const AddIncubPage({super.key});

  @override
  State<AddIncubPage> createState() => _AddIncubPageState();
}

class _AddIncubPageState extends State<AddIncubPage> {
  bool _topIncubUsed = false;
  bool _bottomIncubUsed = false;

  final _contactController = TextEditingController();
  final _usageController = TextEditingController();

  @override
  void dispose() {
    _contactController.dispose();
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

  void _startIncubation() {
    print(
        "\n----------Add Incubation Record----------\nContact: ${_contactController.text}\nTop Incubator used: $_topIncubUsed\nBottom Incubator used: $_bottomIncubUsed\nUsage: ${_usageController.text}\n-----------------------------------------\n");
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
            _buildContactInfoSection(),
            _buildIncubatorSelectionSection(),
            _buildUsageDescriptionSection(),
            _buildStartIncubationButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Contact info",
              style: TextStyle(color: Colors.white, fontSize: 24)),
          const Text("(First name and Last name / phone number)",
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 10),
          _buildTextInputField(
              controller: _contactController, hintText: "Contact Info"),
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
          const Text("Which Incubator(s)?",
              style: TextStyle(color: Colors.white, fontSize: 24)),
          Row(
            children: [
              Checkbox(value: _topIncubUsed, onChanged: _toggleTopIncub),
              const Text("Top",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
          Row(
            children: [
              Checkbox(value: _bottomIncubUsed, onChanged: _toggleBottomIncub),
              const Text("Bottom",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
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
          const Text("Usage Description",
              style: TextStyle(color: Colors.white, fontSize: 24)),
          const Text(
              "(quantity and type of tubes / content / temperature / rpm)",
              style: TextStyle(color: Colors.white70, fontSize: 14)),
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
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
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
