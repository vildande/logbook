import 'package:flutter/material.dart';
import 'package:logbook/models/user_model.dart';

class DataTableWidget extends StatelessWidget {
  final List<User> users;
  final int logsPerPage;
  final int pageIndex;
  final User? initialRecord;

  const DataTableWidget({
    required this.users,
    required this.logsPerPage,
    required this.pageIndex,
    this.initialRecord,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int startIndex = pageIndex * logsPerPage;
    int endIndex = (startIndex + logsPerPage).clamp(0, users.length);
    var pageLogs = users.sublist(startIndex, endIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialRecord != null) {
        int recordIndex = users.indexOf(initialRecord!);
        if (recordIndex != -1 &&
            recordIndex >= startIndex &&
            recordIndex < endIndex) {
          Scrollable.ensureVisible(context,
              duration: const Duration(milliseconds: 300));
        }
      }
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columnSpacing: 16.0,
          dataRowHeight: 60.0,
          columns: const [
            DataColumn(
                label: Text('Status', style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text('Name', style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text('Phone number',
                    style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text('Incubator Type',
                    style: TextStyle(color: Colors.white))),
            DataColumn(
                label:
                    Text('Start Time', style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text('End Time', style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text('Usage Details',
                    style: TextStyle(color: Colors.white))),
            DataColumn(
                label: Text('Comments', style: TextStyle(color: Colors.white))),
          ],
          rows: pageLogs.map((user) {
            return DataRow(
              selected: initialRecord != null && user == initialRecord,
              cells: [
                DataCell(Text(user.status,
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(user.name,
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(user.phoneNumber,
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(user.incubatorType,
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(user.startTime,
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(user.endTime ?? 'Active',
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(user.usageDetails,
                    style: const TextStyle(color: Colors.white))),
                DataCell(Text(user.comment,
                    style: const TextStyle(color: Colors.white))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
