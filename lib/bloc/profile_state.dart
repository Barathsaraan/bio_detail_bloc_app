import '../model/profile_model.dart';

abstract class ProfileState {}

// Initial state
class ProfileInitState extends ProfileState {}

// Loading 
class ProfileLoadingState extends ProfileState {}

// Loaded state
class ProfileLoadedState extends ProfileState {
  final ProfileModel profile;
  ProfileLoadedState({required this.profile});
}

// Updated state — profile updated
class ProfileUpdatedState extends ProfileState {
  final ProfileModel profile;
  ProfileUpdatedState({required this.profile});
}