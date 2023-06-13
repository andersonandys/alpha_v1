class UserModel {
  final String uid;
  final String? email;
  String? name;
  String? phone;

  UserModel({
    required this.uid,
    this.email,
    this.name,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        email: json['email'],
        name: json['name'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'phone': phone,
      };
}
