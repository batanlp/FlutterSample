class FBUserInfo {
  final String userId;
  final String name;
  // ignore: non_constant_identifier_names
  final String first_name;
  // ignore: non_constant_identifier_names
  final String last_name;
  final String email;

  // ignore: non_constant_identifier_names
  FBUserInfo({this.userId, this.name, this.first_name, this.last_name, this.email});

  factory FBUserInfo.fromJson(Map<String, dynamic> json) {
    return FBUserInfo(
      userId: json['id'],
      name: json['name'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
    );
  }
}