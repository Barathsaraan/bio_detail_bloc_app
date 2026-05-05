abstract class ProfileEvent {}

// Profile update event
class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String image;
  final String email;

  UpdateProfileEvent({
    required this.name,
    required this.image,
    required this.email,
  });
}