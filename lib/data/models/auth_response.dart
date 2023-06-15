class AuthResponse {
  String? accessToken;
  String? refreshToken;
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  AuthResponse(
      {this.accessToken,
      this.refreshToken,
      this.id,
      this.firstName,
      this.lastName,
      this.email});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      id: json['user']['id'],
      firstName: json['user']['firstName'],
      lastName: json['user']['lastName'],
      email: json['user']['email'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
