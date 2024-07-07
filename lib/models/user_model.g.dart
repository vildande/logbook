// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      userID: (json['UserID'] as num).toInt(),
      name: json['Name'] as String,
      phoneNumber: json['PhoneNumber'] as String,
      usageDetails: json['UsageDetails'] as String,
      incubatorType: json['IncubatorType'] as String,
      startTime: json['StartTime'] as String,
      endTime: json['EndTime'] as String?,
      comment: json['Comment'] as String,
      status: json['Status'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'UserID': instance.userID,
      'Name': instance.name,
      'PhoneNumber': instance.phoneNumber,
      'UsageDetails': instance.usageDetails,
      'IncubatorType': instance.incubatorType,
      'StartTime': instance.startTime,
      'EndTime': instance.endTime,
      'Comment': instance.comment,
      'Status': instance.status,
    };
