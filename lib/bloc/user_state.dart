part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<User> users;

  const UserLoadedState({required this.users});

  @override
  List<Object> get props => [users];
}

class UserEmptyState extends UserState {}

class UserLoadingFailedState extends UserState {
  final String errorMessage;

  const UserLoadingFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class UserAddedState extends UserState {
  final User user;

  const UserAddedState({required this.user});

  @override
  List<Object> get props => [user];
}
