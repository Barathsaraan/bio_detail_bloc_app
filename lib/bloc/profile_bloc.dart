import 'package:biodetail/data/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/profile_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitState()) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  // Fetch profile from data file
  Future<void> _onFetchProfile(
    FetchProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    debugPrint('ProfileBloc: Fetching profile...');
    emit(ProfileLoadingState()); // loading

    try {
      final profile = await ProfileData.fetchProfile(); // fetch data file
      emit(ProfileLoadedState(profile: profile)); // loaded state
    } catch (e) {
      emit(ProfileInitState()); // error
    }
  }

  // Update profile
  void _onUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) {
    final updatedProfile = ProfileModel(
      name: event.name,
      image: event.image,
      email: event.email,
    );
    emit(ProfileUpdatedState(profile: updatedProfile));
  }

  // Helper
  ProfileModel get currentProfile {
    if (state is ProfileLoadedState) {
      return (state as ProfileLoadedState).profile;
    } else if (state is ProfileUpdatedState) {
      return (state as ProfileUpdatedState).profile;
    }
    return ProfileModel(name: '', image: '', email: '');
  }
}
