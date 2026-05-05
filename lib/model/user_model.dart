class UserModel {
  final String name;
  final String image;
  final String dob;

  UserModel({required this.name, required this.image, required this.dob});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      image: json['image'],
      dob: json['dob'] ?? "",
    );
  }
}
