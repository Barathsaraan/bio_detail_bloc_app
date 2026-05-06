import '../model/profile_model.dart';

class ProfileData {
  static final Map<String, dynamic> _profileJson = {
    "name": "Barath",
    "image":
        "https://upload.wikimedia.org/wikipedia/commons/4/4e/Dot_red_logo.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original",
    "email": "barath@yopmail.com",
  };

  static Future<ProfileModel> fetchProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    return ProfileModel.fromJson(_profileJson);
  }
}