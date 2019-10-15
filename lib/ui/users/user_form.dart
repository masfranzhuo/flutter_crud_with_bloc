import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user_model.dart';

class UserFormScreen extends StatefulWidget {
  final User user;

  UserFormScreen({this.user});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<void> _addData(data) async {
    // User.addUser(data).then((result) {
    //   _scaffoldKey.currentState.showSnackBar(SnackBar(
    //     content: Text('Data createdAt ' + result['createdAt']),
    //   ));
    //   // Navigator.pop(context, true);
    // });
  }

  Future<void> _editData(data) async {
    // User.editUser(data, widget.id).then((result) {
    //   _scaffoldKey.currentState.showSnackBar(SnackBar(
    //     content: Text('Data updatedAt ' +  result['updatedAt']),
    //   ));
    // });
    // Navigator.pop(context, true);
  }

  _formInitValue(User user) {
    _nameController.text = '';// user.firstName;
    _usernameController.text = '';//user.lastName;
    _emailController.text = '';//user.lastName;
  }

  @override
  initState() {
    if (widget.user != null) {
      _formInitValue(widget.user);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:
          AppBar(title: Text((widget.user == null ? 'Add' : 'Edit') + ' User')),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
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
                        var data = {
                          'name': _nameController.text,
                          'job': _usernameController.text,
                          'colour': _emailController.text,
                        };
                        widget.user == null ? _addData(data) : _editData(data);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
