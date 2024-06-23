import 'package:flutter/material.dart';
import '../utility/data_loader.dart';

class DataTableWidget extends StatelessWidget {
  final List<UsageWithUser> usagesWithUser;
  final int logsPerPage;
  final int pageIndex;
  final UsageWithUser? initialRecord;

  const DataTableWidget({
    required this.usagesWithUser,
    required this.logsPerPage,
    required this.pageIndex,
    this.initialRecord,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int startIndex = pageIndex * logsPerPage;
    int endIndex = (startIndex + logsPerPage).clamp(0, usagesWithUser.length);
    var pageLogs = usagesWithUser.sublist(startIndex, endIndex);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (initialRecord != null) {
        int recordIndex = usagesWithUser.indexOf(initialRecord!);
        if (recordIndex != -1 && recordIndex >= startIndex && recordIndex < endIndex) {
          Scrollable.ensureVisible(context, duration: Duration(milliseconds: 300));
        }
      }
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16.0,
        dataRowHeight: 60.0,
        columns: const [
          DataColumn(
              label: Text('Status', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Name', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Phone number', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Incubator Type',
                  style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Start Time', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('End Time', style: TextStyle(color: Colors.white))),
          DataColumn(
              label:
                  Text('Usage Details', style: TextStyle(color: Colors.white))),
          DataColumn(
              label:
                  Text('Actions', style: TextStyle(color: Colors.white))),
        ],
        rows: pageLogs.map((log) {
          return DataRow(
            selected: initialRecord != null && log == initialRecord,
            cells: [
              DataCell(Text(log.usage.status,
                  style: const TextStyle(color: Colors.white))),
              DataCell(Text(log.user.name,
                  style: const TextStyle(color: Colors.white))),
              DataCell(Text(log.user.phoneNumber,
                  style: const TextStyle(color: Colors.white))),
              DataCell(Text(log.usage.incubatorType,
                  style: const TextStyle(color: Colors.white))),
              DataCell(Text(log.usage.startTime,
                  style: const TextStyle(color: Colors.white))),
              DataCell(Text(log.usage.endTime ?? 'Active',
                  style: const TextStyle(color: Colors.white))),
              DataCell(Text(log.usage.usageDetails,
                  style: const TextStyle(color: Colors.white))),
              DataCell(
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          _showEditDialog(context, log);
                        },
                        child: const Text('Edit'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          _showEndDialog(context, log);
                        },
                        child: const Text('End'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          _showCancelDialog(context, log);
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                )
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showEditDialog(BuildContext context, UsageWithUser log) {
    TextEditingController nameController = TextEditingController(text: log.user.name);
    TextEditingController phoneController = TextEditingController(text: log.user.phoneNumber);
    TextEditingController incubatorTypeController = TextEditingController(text: log.usage.incubatorType);
    TextEditingController usageDetailsController = TextEditingController(text: log.usage.usageDetails);

    bool isEditable = false;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Incubation'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEditableRow('Name', nameController, isEditable),
                    _buildEditableRow('Phone Number', phoneController, isEditable),
                    _buildEditableRow('Incubator Type', incubatorTypeController, isEditable),
                    _buildInfoRow('Start Time', log.usage.startTime),
                    _buildInfoRow('End Time', log.usage.endTime ?? 'Active'),
                    _buildEditableRow('Usage Details', usageDetailsController, isEditable, maxLines: 5),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (isEditable) {
                      setState(() {
                        isEditable = false;
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(isEditable ? 'Cancel' : 'Go back'),
                ),
                isEditable
                    ? TextButton(
                        onPressed: () {
                          // Handle the backend call here with the updated information
                          print("Edited with new values");
                          Navigator.of(context).pop();
                        },
                        child: const Text('Confirm'),
                      )
                    : TextButton(
                        onPressed: () {
                          setState(() {
                            isEditable = true;
                          });
                        },
                        child: const Text('Edit'),
                      ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEndDialog(BuildContext context, UsageWithUser log) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('End the incubation?'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Name', log.user.name),
                _buildInfoRow('Phone Number', log.user.phoneNumber),
                _buildInfoRow('Incubator Type', log.usage.incubatorType),
                _buildInfoRow('Start Time', log.usage.startTime),
                _buildInfoRow('End Time', log.usage.endTime ?? 'Active'),
                _buildInfoRow('Usage Details', log.usage.usageDetails, isDetails: true),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Go back'),
            ),
            TextButton(
              onPressed: () {
                print("Ended the incubation");
                Navigator.of(context).pop();
              },
              child: const Text('End the incubation'),
            ),
          ],
        );
      },
    );
  }

  void _showCancelDialog(BuildContext context, UsageWithUser log) {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Incubation'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Name', log.user.name),
                _buildInfoRow('Phone Number', log.user.phoneNumber),
                _buildInfoRow('Incubator Type', log.usage.incubatorType),
                _buildInfoRow('Start Time', log.usage.startTime),
                _buildInfoRow('End Time', log.usage.endTime ?? 'Active'),
                _buildInfoRow('Usage Details', log.usage.usageDetails, isDetails: true),
                const SizedBox(height: 10),
                const Text(
                  'Enter comment (optional)',
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
                const SizedBox(height: 5),
                _buildTextInputField(
                  controller: commentController,
                  hintText: 'Why do you cancel?',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Go back'),
            ),
            TextButton(
              onPressed: () {
                // Handle the backend call here with the comment
                print("Cancelled with comment: ${commentController.text}");
                Navigator.of(context).pop();
              },
              child: const Text('Cancel the incubation'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isDetails = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(color: Colors.black87, fontSize: 16)),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
              textAlign: isDetails ? TextAlign.left : TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller, bool isEditable, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(color: Colors.black87, fontSize: 16)),
          const SizedBox(width: 10),
          Flexible(
            child: isEditable
                ? _buildTextInputField(controller: controller, hintText: label, maxLines: maxLines)
                : Text(
                    controller.text,
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
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
}
