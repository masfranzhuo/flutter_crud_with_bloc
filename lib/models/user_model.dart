class User {
  int id;
  String name;
  String username;
  String email;

  User({
    this.id,
    this.name,
    this.username,
    this.email
  });

  factory User.fromJson(Map<String, dynamic> object) {
    return User(
      id: object['id'] ?? 0,
      name: object['name'] ?? '',
      username: object['username'] ?? '',
      email: object['email'] ?? ''
    );
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'name': this.name,
    'username': this.username,
    'email': this.email
  };
}
