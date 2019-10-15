import 'dart:async';

import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/repository/user_repository.dart';

class UserBloc {
  final _userRepository = UserRepository();

  final _userController = StreamController<List<User>>.broadcast();

  get users => _userController.stream;

  UserBloc({id}) {
    if (id != null) getUser(id);
    else getUsers();
  }

  getUsers() async {
    List<User> users = await _userRepository.getUsers();
    _userController.sink.add(users);
  }

  getUser(int id) async {
    List<User> users = [await _userRepository.getUser(id)];
    _userController.sink.add(users);
  }

  addUser(User user) async {
    List<User> users = [await _userRepository.createUser(user)];
    _userController.sink.add(users);
  }

  updateUser(User user) async {
    List<User> users = [await _userRepository.updateUser(user)];
    _userController.sink.add(users);
  }

  deleteUser(int id) async {
    await _userRepository.deleteUser(id);
    getUsers();
  }

  dispose() {
    _userController.close();
  }
}