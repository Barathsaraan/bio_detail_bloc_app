// All events for UserBloc

abstract class UserEvent {}

// Event to trigger data loading
class FetchUsersEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final String name;
  final String image;
  final String dob;
 
  AddUserEvent({required this.name, required this.image, required this.dob});
}