import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/profile_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
    : super(
        // Default profile data
        ProfileInitState(
          profile: ProfileModel(
            name: 'Barath',
            image:
                'https://upload.wikimedia.org/wikipedia/commons/4/4e/Dot_red_logo.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original',
            email: 'barath@yopmail.com',
          ),
        ),
      ) {
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  void _onUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) {
    // Updated profile create பண்றோம்
    final updatedProfile = ProfileModel(
      name: event.name,
      image: event.image,
      email: event.email,
    );

    emit(ProfileUpdatedState(profile: updatedProfile));
  }

  // Helper — current profile எடுக்க (any state-லயும் profile கிடைக்கும்)
  ProfileModel get currentProfile {
    if (state is ProfileInitState) {
      return (state as ProfileInitState).profile;
    } else {
      return (state as ProfileUpdatedState).profile;
    }
  }
}
