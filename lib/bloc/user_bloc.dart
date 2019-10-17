import 'dart:async';

import 'package:flutter_crud/helper/bloc/bloc_provider.dart';
import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/repository/user_repository.dart';

class UserBloc extends BlocBase {
  final _userRepository = UserRepository();

  final StreamController _usersController = StreamController<List<User>>.broadcast();
  final StreamController _userController = StreamController<User>.broadcast();

  Sink get _usersSink => _usersController.sink;
  Sink get _userSink => _userController.sink;

  Stream<List<User>> get usersStream => _usersController.stream;
  Stream<User> get userStream => _userController.stream;

  UserBloc({id}) {
    if (id != null) getUser(id);
    else getUsers();
  }

  getUsers() async {
    _usersSink.add(await _userRepository.getUsers());
  }

  getUser(int id) async {
    _userSink.add(await _userRepository.getUser(id));
  }

  addUser(User user) async {
    _userSink.add(await _userRepository.createUser(user));
  }

  updateUser(User user) async {
    _userSink.add(await _userRepository.updateUser(user));
  }

  deleteUser(int id) async {
    await _userRepository.deleteUser(id);
    getUsers();
  }

  dispose() {
    _usersController.close();
    _userController.close();
  }
}