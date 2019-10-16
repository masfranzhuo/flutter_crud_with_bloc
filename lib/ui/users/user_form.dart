import 'package:flutter/material.dart';
import 'package:flutter_crud/bloc/user_bloc.dart';
import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/ui/widgets/loading_widget.dart';

class UserFormScreen extends StatefulWidget {
  final int id;

  UserFormScreen({this.id: 0});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserBloc userBloc;

  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userBloc = UserBloc(id: widget.id);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text((widget.id == 0 ? 'Add' : 'Edit') + ' User')),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: StreamBuilder(
                  stream: userBloc.usersStream,
                  builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                    if (!snapshot.hasData) return Loading();
                    User user = snapshot.data[0];
                    _nameController.value = _nameController.value.copyWith(text: user.name);
                    _usernameController.value = _usernameController.value.copyWith(text: user.username);
                    _emailController.value = _emailController.value.copyWith(text: user.email);
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                              ),
                              onChanged: (value) {
                                user.name = value;
                              },
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              }),
                          TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                              ),
                              onChanged: (value) {
                                user.username = value;
                              },
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'Username cannot be empty';
                                }
                                return null;
                              }),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                              onChanged: (value) {
                                user.email = value;
                              },
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'Email cannot be empty';
                                }
                                return null;
                              }),
                          RaisedButton(
                            child: Text('Submit'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                if (widget.id == 0) {
                                  userBloc.addUser(user);
                                } else {
                                  userBloc.updateUser(user);
                                }
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text(user.name + (widget.id == 0 ? ' created' : ' updated')))
                                );
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ));
  }
}
