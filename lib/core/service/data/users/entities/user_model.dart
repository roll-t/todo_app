class UserModel {
  final String id;
  final String email;
  final String displayName;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
    };
  }
}
