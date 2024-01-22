class UserModel {
  final int id;
  final String name;
  final String email;
  final String image;
  final String password;
  final String userRole;
  final String createDate;
  final String updateDate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.password,
    required this.userRole,
    required this.createDate,
    required this.updateDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      password: json['password'] ?? '',
      userRole: json['role'] ?? '',
      createDate: json['createDate'] ?? '',
      updateDate: json['updateDate'] ?? '',
    );
  }
}


class AuthResponse {
  final UserModel data;
  final String accessToken;

  AuthResponse({
    required this.data,
    required this.accessToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      data: UserModel.fromJson(json['message']),
      accessToken: json['token'],
    );
  }
}
