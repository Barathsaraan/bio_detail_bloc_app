
import '../model/profile_model.dart';

abstract class ProfileState {}

// Initial state — default profile
class ProfileInitState extends ProfileState {
  final ProfileModel profile;

  ProfileInitState({required this.profile});
}

// Updated state — profile updated
class ProfileUpdatedState extends ProfileState {
  final ProfileModel profile;

  ProfileUpdatedState({required this.profile});
}