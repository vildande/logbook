import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import '../models/user_model.dart';
import '../utility/data_loader.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DataLoader dataLoader;

  UserBloc({required this.dataLoader}) : super(UserInitial()) {
    on<GetUserEvent>(_onGetUserEvent);
    on<AddUserEvent>(_onAddUserEvent);
    on<GetInProgressUsersEvent>(_onGetInProgressUsersEvent);
    on<EditUserEvent>(_onEditUserEvent);
    on<CancelUserEvent>(_onCancelUserEvent);
    on<EndUserEvent>(_onEndUserEvent);
  }

  Future<void> _onGetUserEvent(
      GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final users = await dataLoader.loadUsers();
      if (users.isEmpty) {
        emit(UserEmptyState());
      } else {
        emit(UserLoadedState(users: users));
      }
    } catch (e) {
      emit(UserLoadingFailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _onAddUserEvent(
      AddUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      await dataLoader.sendIncubationData(event.user);
      emit(UserAddedState(user: event.user));
      final users = await dataLoader.loadUsers();
      emit(UserLoadedState(users: users));
    } catch (e) {
      emit(UserLoadingFailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _onGetInProgressUsersEvent(
      GetInProgressUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final users = await dataLoader.loadInProgressUsers();
      if (users.isEmpty) {
        emit(UserEmptyState());
      } else {
        emit(UserLoadedState(users: users));
      }
    } catch (e) {
      emit(UserLoadingFailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _onEditUserEvent(
      EditUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      await dataLoader.updateIncubationData(event.user);
      final users = await dataLoader.loadUsers();
      emit(UserLoadedState(users: users));
    } catch (e) {
      emit(UserLoadingFailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _onCancelUserEvent(
      CancelUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final updatedUser = event.user.copyWith(
        status: 'Cancelled',
        endTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
        comment: event.comment,
      );
      await dataLoader.updateIncubationData(updatedUser);
      final users = await dataLoader.loadUsers();
      emit(UserLoadedState(users: users));
    } catch (e) {
      emit(UserLoadingFailedState(errorMessage: e.toString()));
    }
  }

  Future<void> _onEndUserEvent(
      EndUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final updatedUser = event.user.copyWith(
        status: 'Completed',
        endTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      );
      await dataLoader.updateIncubationData(updatedUser);
      final users = await dataLoader.loadUsers();
      emit(UserLoadedState(users: users));
    } catch (e) {
      emit(UserLoadingFailedState(errorMessage: e.toString()));
    }
  }
}
