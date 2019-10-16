import 'dart:async';

import 'package:flutter_crud/helper/bloc/bloc_provider.dart';
import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/repository/user_repository.dart';

class UserBloc extends BlocBase {
  final _userRepository = UserRepository();

  final StreamController _userController = StreamController<List<User>>.broadcast();

  Sink get _usersSink =>_userController.sink;

  Stream<List<User>> get usersStream => _userController.stream;

  UserBloc({id}) {
    if (id != null) getUser(id);
    else getUsers();
  }

  getUsers() async {
    _usersSink.add(await _userRepository.getUsers());
  }

  getUser(int id) async {
    List<User> users = [await _userRepository.getUser(id)];
    _usersSink.add(users);
  }

  addUser(User user) async {
    List<User> users = [await _userRepository.createUser(user)];
    _usersSink.add(users);
  }

  updateUser(User user) async {
    List<User> users = [await _userRepository.updateUser(user)];
    _usersSink.add(users);
  }

  deleteUser(int id) async {
    await _userRepository.deleteUser(id);
    getUsers();
  }

  dispose() {
    _userController.close();
  }
}