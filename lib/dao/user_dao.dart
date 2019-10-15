import 'dart:convert';

import 'package:flutter_crud/config/constants/api_url.dart';
import 'package:flutter_crud/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserDao {
  static final String userModelUrl = API.MAIN_URL + 'users/';

  Future<List<User>> getUsers() async {
    String url = userModelUrl;

    var response = await http.get(url);
    var result = await json.decode(response.body);

    List<User> users = [];
    for(int i = 0; i< result.length; i++) {
      users.add(User.fromJson(result[i]));
    }

    return users;
  }

  Future<User> getUser(int id) async {
    String url = userModelUrl + id.toString();

    var response = await http.get(url);
    var result = json.decode(response.body);

    User user = User.fromJson(result);

    return user;
  }

  Future<User> createUser(User user) async {
    String url = userModelUrl;

    var response = await http.post(url, body: user.toJson());
    var result = json.decode(response.body);

    user = User.fromJson(result);

    return user;
  }

  Future<int> updateUser(User user) async {
    String url = userModelUrl + user.id.toString();

    var response = await http.put(url, body: user.toJson());
    var result = json.decode(response.body);

    return result;
  }

  Future deleteUser(int id) async {
    String url = userModelUrl + id.toString();

    await http.delete(url);
  }
}