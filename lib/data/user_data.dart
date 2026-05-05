import '../model/user_model.dart';

class UserData {
  static final List<Map<String, dynamic>> _usersJson = [
    {
      "name": "Test1",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/4/4e/Dot_red_logo.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original",
      "dob": "02-02-2001",
    },
    // {
    //   "name": "Test2",
    //   "image":
    //       "https://upload.wikimedia.org/wikipedia/commons/4/4e/Dot_red_logo.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original",
    //   "dob": "02-02-2001",
    // },
    // {
    //   "name": "Test3",
    //   "image":
    //       "https://upload.wikimedia.org/wikipedia/commons/4/4e/Dot_red_logo.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original",
    //   "dob": "02-02-2001",
    // },
    // {
    //   "name": "Test4",
    //   "image":
    //       "https://upload.wikimedia.org/wikipedia/commons/4/4e/Dot_red_logo.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original",
    //   "dob": "02-02-2001",
    // },
    // {
    //   "name": "Test5",
    //   "image":
    //       "https://upload.wikimedia.org/wikipedia/commons/4/4e/Dot_red_logo.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original",
    //   "dob": "02-02-2001",
    // },
  ];

  // delay
  static Future<List<UserModel>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    return _usersJson.map((json) => UserModel.fromJson(json)).toList();
  }
}
