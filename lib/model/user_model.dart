class UserModel {
  String profileStatus = "";
  String role = "";
  String phone = "";
  String phone_verified_at = "";
  String accessToken = "";
  String tokenType = "";
  int expiresIn = 0;

  UserModel();

  UserModel.fromJson(dynamic json) {
    profileStatus = json["profile_status"] ?? "";
    role = json['role'] ?? "";
    phone = json['empProfileImg'] ?? "";
    phone_verified_at = json['phone_verified_at'] ?? "";
    accessToken = json['access_token'] ?? "";
    tokenType = json['token_type'] ?? "";
    expiresIn = json['expires_in'] ?? 0;
  }
}
