import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/screens/users/user_form.dart';

class UserScreen extends StatefulWidget {
  final int id;

  UserScreen(this.id);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  User user;

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    User.getUser(widget.id).then((result) {
      setState(() {
        user = result;
        isLoading = false;
      });
    });
  }

  @override
  initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('User'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => UserFormScreen(widget.id, user)))
                .then((val) {
                  _loadData();
                });
            },
          )
        ],
      ),
      body: Center(
        child: isLoading ? CircularProgressIndicator() : 
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: Image(
                    image: NetworkImage(user.avatar)
                  )
                ),
                Text(user.firstName + ' ' +user.lastName),
                Text(user.email)
              ],
            )
          ),
        ),
      )
    );
  }
}