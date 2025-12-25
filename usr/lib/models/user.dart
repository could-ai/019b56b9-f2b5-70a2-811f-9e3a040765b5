class User {
  final String id;
  final String name;
  final String email;
  final String position;
  final bool isAdmin;
  final bool isApproved;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
    required this.isAdmin,
    required this.isApproved,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      position: json['position'],
      isAdmin: json['isAdmin'] ?? false,
      isApproved: json['isApproved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'position': position,
      'isAdmin': isAdmin,
      'isApproved': isApproved,
    };
  }
}
