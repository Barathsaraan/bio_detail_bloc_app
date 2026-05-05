import 'package:biodetail/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/user_data.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // Start with InitState
  UserBloc() : super(UserInitState()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<AddUserEvent>(_onAddUser);
  }

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      // fetch data
      final users = await UserData.fetchUsers();
      // Emit loaded with data
      emit(UserLoadedState(users: users));
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  void _onAddUser(AddUserEvent event, Emitter<UserState> emit) {
    // Only add if currently in loaded state
    if (state is UserLoadedState) {
      final currentUsers = (state as UserLoadedState).users;

      // Create new user from event data
      final newUser = UserModel(
        name: event.name,
        image: event.image,
        dob: event.dob,
      );

      // Append new user to existing list and emit
      emit(UserLoadedState(users: [newUser, ...currentUsers]));
    }
  }
}
