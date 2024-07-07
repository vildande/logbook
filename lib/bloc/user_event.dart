part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final User user;
  const AddUserEvent({required this.user});
  @override
  List<Object> get props => [user];
}

class GetInProgressUsersEvent extends UserEvent {}

class EditUserEvent extends UserEvent {
  final User user;
  const EditUserEvent({required this.user});
  @override
  List<Object> get props => [user];
}

class CancelUserEvent extends UserEvent {
  final User user;
  final String comment;
  const CancelUserEvent({required this.user, required this.comment});
  @override
  List<Object> get props => [user, comment];
}

class EndUserEvent extends UserEvent {
  final User user;
  const EndUserEvent({required this.user});
  @override
  List<Object> get props => [user];
}
