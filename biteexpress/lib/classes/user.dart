class User {
  final String firstname;
  final String lastname;
  final String phone;
  final String email;
  final String userType;
  final String userId;

  User({
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.userType,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstname: json['firstname'],
        lastname: json['lastname'],
        phone: json['phone'],
        userType: json['userType'],
        email: json['email'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'userType': userType,
      'userId': userId
    };
  }
}
