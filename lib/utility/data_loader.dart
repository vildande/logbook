import 'package:flutter/services.dart' show rootBundle;
import 'package:logbook/models/user_model.dart';

class DataLoader {
  Future<List<UsageWithUser>> loadUsagesWithUser() async {
    final jsonString = await rootBundle.loadString('assets/sample_data.json');
    List<User> users = parseUsers(jsonString);
    List<UsageWithUser> usageWithUsers = users.expand(
      (user) => user.usages.map((usage) => UsageWithUser(user, usage))
    ).toList();
    
    
    usageWithUsers.sort((a, b) {
      DateTime startTimeA = DateTime.parse(a.usage.startTime);
      DateTime startTimeB = DateTime.parse(b.usage.startTime);
      return startTimeB.compareTo(startTimeA);
    });

    usageWithUsers.sort((a,b) => a.usage.status.toLowerCase() == 'completed' 
    || a.usage.status.toLowerCase() == 'cancelled'  ? 1 : -1);

    // In Progress 
    // Cancelled
    // Completed

    return usageWithUsers;
  }
}

class UsageWithUser {
  final User user;
  final Usage usage;

  UsageWithUser(this.user, this.usage);
}
