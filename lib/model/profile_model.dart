class ProfileModel {
  final String name;
  final String image;
  final String email;

  ProfileModel({
    required this.name,
    required this.image,
    required this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // using for changing the one field in the model
  ProfileModel copyWith({
    String? name,
    String? image,
    String? email,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
    );
  }
}