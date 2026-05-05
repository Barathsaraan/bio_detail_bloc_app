import '../model/user_model.dart';

// All states for UserBloc
abstract class UserState {}

// Initial state
class UserInitState extends UserState {}

// Loading state while fetching data
class UserLoadingState extends UserState {}

// Loaded state data fetched success
class UserLoadedState extends UserState {
  final List<UserModel> users;

  UserLoadedState({required this.users});
}

// Error state
class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});
}