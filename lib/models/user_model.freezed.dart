// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: 'UserID')
  int get userID => throw _privateConstructorUsedError;
  @JsonKey(name: 'Name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'PhoneNumber')
  String get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'UsageDetails')
  String get usageDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'IncubatorType')
  String get incubatorType => throw _privateConstructorUsedError;
  @JsonKey(name: 'StartTime')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'EndTime')
  String? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'Comment')
  String get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'Status')
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: 'UserID') int userID,
      @JsonKey(name: 'Name') String name,
      @JsonKey(name: 'PhoneNumber') String phoneNumber,
      @JsonKey(name: 'UsageDetails') String usageDetails,
      @JsonKey(name: 'IncubatorType') String incubatorType,
      @JsonKey(name: 'StartTime') String startTime,
      @JsonKey(name: 'EndTime') String? endTime,
      @JsonKey(name: 'Comment') String comment,
      @JsonKey(name: 'Status') String status});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? usageDetails = null,
    Object? incubatorType = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? comment = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      usageDetails: null == usageDetails
          ? _value.usageDetails
          : usageDetails // ignore: cast_nullable_to_non_nullable
              as String,
      incubatorType: null == incubatorType
          ? _value.incubatorType
          : incubatorType // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'UserID') int userID,
      @JsonKey(name: 'Name') String name,
      @JsonKey(name: 'PhoneNumber') String phoneNumber,
      @JsonKey(name: 'UsageDetails') String usageDetails,
      @JsonKey(name: 'IncubatorType') String incubatorType,
      @JsonKey(name: 'StartTime') String startTime,
      @JsonKey(name: 'EndTime') String? endTime,
      @JsonKey(name: 'Comment') String comment,
      @JsonKey(name: 'Status') String status});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userID = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? usageDetails = null,
    Object? incubatorType = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? comment = null,
    Object? status = null,
  }) {
    return _then(_$UserImpl(
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      usageDetails: null == usageDetails
          ? _value.usageDetails
          : usageDetails // ignore: cast_nullable_to_non_nullable
              as String,
      incubatorType: null == incubatorType
          ? _value.incubatorType
          : incubatorType // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {@JsonKey(name: 'UserID') required this.userID,
      @JsonKey(name: 'Name') required this.name,
      @JsonKey(name: 'PhoneNumber') required this.phoneNumber,
      @JsonKey(name: 'UsageDetails') required this.usageDetails,
      @JsonKey(name: 'IncubatorType') required this.incubatorType,
      @JsonKey(name: 'StartTime') required this.startTime,
      @JsonKey(name: 'EndTime') this.endTime,
      @JsonKey(name: 'Comment') required this.comment,
      @JsonKey(name: 'Status') required this.status});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: 'UserID')
  final int userID;
  @override
  @JsonKey(name: 'Name')
  final String name;
  @override
  @JsonKey(name: 'PhoneNumber')
  final String phoneNumber;
  @override
  @JsonKey(name: 'UsageDetails')
  final String usageDetails;
  @override
  @JsonKey(name: 'IncubatorType')
  final String incubatorType;
  @override
  @JsonKey(name: 'StartTime')
  final String startTime;
  @override
  @JsonKey(name: 'EndTime')
  final String? endTime;
  @override
  @JsonKey(name: 'Comment')
  final String comment;
  @override
  @JsonKey(name: 'Status')
  final String status;

  @override
  String toString() {
    return 'User(userID: $userID, name: $name, phoneNumber: $phoneNumber, usageDetails: $usageDetails, incubatorType: $incubatorType, startTime: $startTime, endTime: $endTime, comment: $comment, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.usageDetails, usageDetails) ||
                other.usageDetails == usageDetails) &&
            (identical(other.incubatorType, incubatorType) ||
                other.incubatorType == incubatorType) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userID, name, phoneNumber,
      usageDetails, incubatorType, startTime, endTime, comment, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {@JsonKey(name: 'UserID') required final int userID,
      @JsonKey(name: 'Name') required final String name,
      @JsonKey(name: 'PhoneNumber') required final String phoneNumber,
      @JsonKey(name: 'UsageDetails') required final String usageDetails,
      @JsonKey(name: 'IncubatorType') required final String incubatorType,
      @JsonKey(name: 'StartTime') required final String startTime,
      @JsonKey(name: 'EndTime') final String? endTime,
      @JsonKey(name: 'Comment') required final String comment,
      @JsonKey(name: 'Status') required final String status}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: 'UserID')
  int get userID;
  @override
  @JsonKey(name: 'Name')
  String get name;
  @override
  @JsonKey(name: 'PhoneNumber')
  String get phoneNumber;
  @override
  @JsonKey(name: 'UsageDetails')
  String get usageDetails;
  @override
  @JsonKey(name: 'IncubatorType')
  String get incubatorType;
  @override
  @JsonKey(name: 'StartTime')
  String get startTime;
  @override
  @JsonKey(name: 'EndTime')
  String? get endTime;
  @override
  @JsonKey(name: 'Comment')
  String get comment;
  @override
  @JsonKey(name: 'Status')
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
