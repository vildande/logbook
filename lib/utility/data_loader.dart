import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logbook/models/user_model.dart';
import 'package:intl/intl.dart';
import 'data_provider.dart';

class DataLoader {
  final String apiUrl = 'https://web-production-9be6.up.railway.app/users';

  Future<List<User>> loadUsers() async {
    final response = await DataProvider.getRequest(endpoint: apiUrl);

    if (response.statusCode == 200) {
      List<User> users = parseUsers(jsonDecode(response.body) as List<dynamic>);

      users.sort((a, b) {
        DateTime startTimeA = parseDate(a.startTime);
        DateTime startTimeB = parseDate(b.startTime);
        return startTimeB.compareTo(startTimeA);
      });

      users.sort((a, b) => (a.status.toLowerCase() == 'completed' ||
              a.status.toLowerCase() == 'cancelled')
          ? 1
          : -1);

      return users;
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  Future<List<User>> loadInProgressUsers() async {
    final response = await DataProvider.getRequest(endpoint: apiUrl);

    if (response.statusCode == 200) {
      List<User> users = parseUsers(jsonDecode(response.body) as List<dynamic>);
      return users
          .where((user) => user.status.toLowerCase() == 'in progress')
          .toList();
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  DateTime parseDate(String dateStr) {
    try {
      return DateFormat('yyyy-MM-dd HH:mm').parse(dateStr);
    } catch (e) {
      throw FormatException('Invalid date format', dateStr);
    }
  }

  Future<void> sendIncubationData(User user) async {
    try {
      final Map<String, dynamic> userData = user.toJson();
      userData['StartTime'] = user.startTime.isNotEmpty
          ? DateFormat('yyyy-MM-dd HH:mm')
              .format(DateTime.parse(user.startTime))
          : null;
      userData['EndTime'] = user.endTime != null
          ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(user.endTime!))
          : null;

      final response = await DataProvider.postRequest(
        endpoint: apiUrl,
        body: userData,
      );

      if (response.statusCode != 201) {
        print('Failed to add user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add user');
      }
    } catch (e) {
      print('Error sending incubation data: $e');
      rethrow;
    }
  }

  Future<void> updateIncubationData(User user) async {
    try {
      final Map<String, dynamic> userData = user.toJson();
      userData['StartTime'] = user.startTime.isNotEmpty
          ? DateFormat('yyyy-MM-dd HH:mm')
              .format(DateTime.parse(user.startTime))
          : null;
      userData['EndTime'] = user.endTime != null
          ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(user.endTime!))
          : null;

      final response = await DataProvider.putRequest(
        endpoint: '$apiUrl/${user.userID}',
        body: userData,
      );

      if (response.statusCode != 200) {
        print('Failed to update user. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update user');
      }
    } catch (e) {
      print('Error updating incubation data: $e');
      rethrow;
    }
  }
}
