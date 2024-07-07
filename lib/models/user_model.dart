import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'UserID') required int userID,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'PhoneNumber') required String phoneNumber,
    @JsonKey(name: 'UsageDetails') required String usageDetails,
    @JsonKey(name: 'IncubatorType') required String incubatorType,
    @JsonKey(name: 'StartTime') required String startTime,
    @JsonKey(name: 'EndTime') String? endTime,
    @JsonKey(name: 'Comment') required String comment,
    @JsonKey(name: 'Status') required String status,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

List<User> parseUsers(List<dynamic> json) {
  return json
      .map((dynamic user) => User.fromJson(user as Map<String, dynamic>))
      .toList();
}
