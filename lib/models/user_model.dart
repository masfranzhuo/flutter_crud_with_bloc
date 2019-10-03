import 'dart:convert';

import 'package:flutter_crud/config/constants/api_url.dart';
import 'package:http/http.dart' as http;

class User {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar
  });

  factory User.createUser(Map<String, dynamic> object) {
    return User(
      id: object['id'] ?? 0,
      email: object['email'] ?? '',
      firstName: object['first_name'] ?? '',
      lastName: object['last_name'] ?? '',
      avatar: object['avatar'] ?? '',
    );
  }

  static Future<List<User>> getListUsers(String page) async {
    String apiURL = API.MAIN_URL + '/users?page=' + page;

    var result = await http.get(apiURL);
    var jsonObject = json.decode(result.body);

    List<dynamic> listData = (jsonObject as Map<dynamic, dynamic>)['data'];

    List<User> data = [];
    for (int i = 0; i < listData.length; i++) {
      data.add(User.createUser(listData[i]));
    }

    return data;
  }

  static Future<User> getUser(int id) async {
    String apiURL = API.MAIN_URL + '/users/' + id.toString();

    var result = await http.get(apiURL);
    var jsonObject = json.decode(result.body);
    var data = (jsonObject as Map<dynamic, dynamic>)['data'];

    return User.createUser(data);
  }

  static Future<Map<String, dynamic>> addUser(Map<String, dynamic> object) async {
    String apiURL = API.MAIN_URL + '/users';

    var result = await http.post(apiURL, body: object);
    var jsonObject = json.decode(result.body);

    return jsonObject;
  }

  static Future<Map<String, dynamic>> editUser(Map<String, dynamic> object, int id) async {
    String apiURL = API.MAIN_URL + '/users/' + id.toString();

    var result = await http.put(apiURL, body: object);
    var jsonObject = json.decode(result.body);

    return jsonObject;
  }

  static Future<dynamic> removeUser(int id) async {
    String apiURL = API.MAIN_URL + '/users/' + id.toString();

    await http.delete(apiURL);

    return true;
  }
}
