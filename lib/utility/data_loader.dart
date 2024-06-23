import 'dart:convert';  // Add this import statement
import 'package:flutter/services.dart' show rootBundle;
import 'package:logbook/models/user_model.dart';

class DataLoader {
  Future<List<UsageWithUser>> loadUsagesWithUser() async {
    final jsonString = await rootBundle.loadString('assets/sample_data.json');
    List<User> users = parseUsers(jsonString);
    List<UsageWithUser> usageWithUsers = users.expand(
      (user) => user.usages.map((usage) => UsageWithUser(usage: usage, user: user))
    ).toList();

    usageWithUsers.sort((a, b) {
      DateTime startTimeA = DateTime.parse(a.usage.startTime);
      DateTime startTimeB = DateTime.parse(b.usage.startTime);
      return startTimeB.compareTo(startTimeA);
    });

    usageWithUsers.sort((a, b) => a.usage.status.toLowerCase() == 'completed' 
    || a.usage.status.toLowerCase() == 'cancelled' ? 1 : -1);

    return usageWithUsers;
  }
}

class UsageWithUser {
  final User user;
  final Usage usage;
  bool isExpanded;

  UsageWithUser({
    required this.user,
    required this.usage,
    this.isExpanded = false,
  });
}

class User {
  final int userID;
  final String name;
  final String phoneNumber;
  final List<Usage> usages;

  User({
    required this.userID,
    required this.name,
    required this.phoneNumber,
    required this.usages,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['UserID'],
      name: json['Name'],
      phoneNumber: json['PhoneNumber'],
      usages: (json['Usages'] as List).map((i) => Usage.fromJson(i)).toList(),
    );
  }
}

class Usage {
  final int usageID;
  final String usageDetails;
  final String incubatorType;
  final String startTime;
  final String? endTime;
  final String comment;
  final String status;

  Usage({
    required this.usageID,
    required this.usageDetails,
    required this.incubatorType,
    required this.startTime,
    this.endTime,
    required this.comment,
    required this.status,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      usageID: json['UsageID'],
      usageDetails: json['UsageDetails'],
      incubatorType: json['IncubatorType'],
      startTime: json['StartTime'],
      endTime: json['EndTime'],
      comment: json['Comment'],
      status: json['Status'],
    );
  }
}

List<User> parseUsers(String jsonStr) {
  final parsed = jsonDecode(jsonStr)['Users'].cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
