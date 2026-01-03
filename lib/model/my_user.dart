class MyUser {
  static const String userCollection = 'Users';

  String id;
  String name;
  String email;

  MyUser({required this.id, required this.name, required this.email});

  /// json to object
  MyUser.fromJson(Map<String, dynamic> data)
    : this(
        id: data['id'] as String,
        email: data['email'] as String,
        name: data['name'] as String,
      );

  /// object to json
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
