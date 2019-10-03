import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user_model.dart';

class UserFormScreen extends StatefulWidget {
  final int id;
  final User user;

  UserFormScreen(this.id, this.user);

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobController = TextEditingController();

  Future<void> _addData(data) async {
    User.addUser(data).then((result) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Data createdAt ' + result['createdAt']),
      ));
      // Navigator.pop(context, true);
    });
  }

  Future<void> _editData(data) async {
    User.editUser(data, widget.id).then((result) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Data updatedAt ' +  result['updatedAt']),
      ));
    });
    // Navigator.pop(context, true);
  }

  _formInitValue(User user) {
    _nameController.text = user.firstName;
    _jobController.text = user.lastName;
  }

  @override
  initState() {
    if (widget.id != 0) {
      _formInitValue(widget.user);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar:
          AppBar(title: Text((widget.id == 0 ? 'Add' : 'Edit') + ' User')),
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
                    controller: _jobController,
                    decoration: InputDecoration(
                      labelText: 'Job',
                    ),
                    validator: (value) {
                      if (value.length < 1) {
                        return 'Job cannot be empty';
                      }
                      return null;
                    }),
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        var data = {
                          'name': _nameController.text,
                          'job': _jobController.text,
                        };
                        widget.id == 0 ? _addData(data) : _editData(data);
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
