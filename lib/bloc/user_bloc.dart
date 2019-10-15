import 'dart:async';

import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/repository/user_repository.dart';

class UserBloc {
  final _userRepository = UserRepository();

  final _userController = StreamController<List<User>>.broadcast();

  get users => _userController.stream;

  UserBloc() {
    getUsers();
  }

  getUsers() async {
    _userController.sink.add(await _userRepository.getUsers());
  }

  getUser(int id) async {
    await _userRepository.getUser(id);
    getUsers();
  }

  addUser(User user) async {
    await _userRepository.createUser(user);
    getUsers();
  }

  updateUser(User user) async {
    await _userRepository.updateUser(user);
    getUsers();
  }

  deleteUser(int id) async {
    await _userRepository.deleteUser(id);
    getUsers();
  }

  dispose() {
    _userController.close();
  }
}