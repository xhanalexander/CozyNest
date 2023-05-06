class UserAuth {
  final int? id;
  final String username;
  final String email;
  final String password;

  UserAuth({this.id, required this.username, required this.email ,required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  static UserAuth fromMap(Map<String, dynamic> map) {
    return UserAuth(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}
