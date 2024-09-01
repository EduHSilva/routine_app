class UserModel {
  final int id;
  final String name;
  final String email;
  final String lastLogin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      lastLogin: json['lastLogin'],
    );
  }
}

class AuthResponse {
  final UserModel user;
  final String token;
  final String message;

  AuthResponse({
    required this.user,
    required this.token,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: UserModel.fromJson(json['data']['user']),
      token: json['data']['token'],
      message: json['message'],
    );
  }
}

class AuthRequest {
  final String email;
  final String password;

  AuthRequest({required this.email, required this.password});
}