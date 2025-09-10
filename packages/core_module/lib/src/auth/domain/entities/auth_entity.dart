class AuthEntity {
  final String email;
  final String password;

  AuthEntity({required this.email, required this.password});

  static AuthEntity fromMap(dynamic json) {
    return AuthEntity(email: json['email'], password: json['password']);
  }

  static Map<String, dynamic> toMap(AuthEntity data) {
    return {'email': data.email, 'password': data.password};
  }
}
