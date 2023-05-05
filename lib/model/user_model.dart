class UserAuth {
  final int id;
  final String username;
  final String email;
  final String password;

  UserAuth({required this.id, required this.username, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
    return map;
  }

  UserAuth.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      username = map['username'],
      email = map['email'],
      password = map['password'];

}
