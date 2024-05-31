import 'package:flutter/services.dart' show rootBundle;
import 'package:logbook/models/user_model.dart';

class DataLoader {
  Future<List<UsageWithUser>> loadUsagesWithUser() async {
    final jsonString = await rootBundle.loadString('assets/sample_data.json');
    List<User> users = parseUsers(jsonString);
    return users
        .expand(
            (user) => user.usages.map((usage) => UsageWithUser(user, usage)))
        .toList();
  }
}

class UsageWithUser {
  final User user;
  final Usage usage;

  UsageWithUser(this.user, this.usage);
}
