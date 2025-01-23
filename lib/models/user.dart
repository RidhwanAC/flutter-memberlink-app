class User {
  final String id;
  final String username;
  final String email;
  final String dateReg;
  String profilePic;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.dateReg,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      dateReg: json['date_reg'] ?? '',
      profilePic: json['profile_pic'] ?? 'assets/images/default_avatar.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'date_reg': dateReg,
      'profile_pic': profilePic,
    };
  }
}
