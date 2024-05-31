import 'package:flutter/material.dart';
import '../utility/data_loader.dart';

class DataTableWidget extends StatelessWidget {
  final List<UsageWithUser> usagesWithUser;
  final int logsPerPage;
  final int pageIndex;

  const DataTableWidget({
    required this.usagesWithUser,
    required this.logsPerPage,
    required this.pageIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int startIndex = pageIndex * logsPerPage;
    int endIndex = (startIndex + logsPerPage).clamp(0, usagesWithUser.length);
    var pageLogs = usagesWithUser.sublist(startIndex, endIndex);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 16.0,
        dataRowHeight: 60.0,
        columns: const [
          DataColumn(
              label: Text('Name', style: TextStyle(color: Colors.white))),
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
              label: Text('Comment', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Status', style: TextStyle(color: Colors.white))),
        ],
        rows: pageLogs.map((log) {
          return DataRow(cells: [
            DataCell(Text(log.user.name,
                style: const TextStyle(color: Colors.white))),
            DataCell(Text(log.usage.incubatorType,
                style: const TextStyle(color: Colors.white))),
            DataCell(Text(log.usage.startTime,
                style: const TextStyle(color: Colors.white))),
            DataCell(Text(log.usage.endTime ?? 'Active',
                style: const TextStyle(color: Colors.white))),
            DataCell(Text(log.usage.usageDetails,
                style: const TextStyle(color: Colors.white))),
            DataCell(Text(log.usage.comment,
                style: const TextStyle(color: Colors.white))),
            DataCell(Text(log.usage.status,
                style: const TextStyle(color: Colors.white))),
          ]);
        }).toList(),
      ),
    );
  }
}
