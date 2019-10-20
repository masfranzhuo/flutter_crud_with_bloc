import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
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

  // equal
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // factory User.fromJson(Map<String, dynamic> object) {
  //   return User(
  //     id: object['id'] ?? 0,
  //     name: object['name'] ?? '',
  //     username: object['username'] ?? '',
  //     email: object['email'] ?? ''
  //   );
  // }

  //equal
  Map<String, dynamic> toJson() => _$UserToJson(this);
  // Map<String, dynamic> toJson() => {
  //   'id': this.id.toString() ?? '',
  //   'name': this.name ?? '',
  //   'username': this.username ?? '',
  //   'email': this.email ?? ''
  // };
}
