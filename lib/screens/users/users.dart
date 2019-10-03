import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/screens/users/user.dart';
import 'package:flutter_crud/screens/users/user_form.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading = true;
  List<User> users = [];

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    User.getListUsers("1").then((result) {
      setState(() {
        users = result;
        isLoading = false;
      });
    });
  }

  Future<void> _removeData(id) async {
    User.removeUser(id).then((response) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Id ${id.toString()} deleted'),
      ));
      _loadData();
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
        title: Text('List Users'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => UserFormScreen(0, User())))
                .then((val) {
                  _loadData();
                });
            },
          )
        ],
      ),
      body: Center(
        child: isLoading ? CircularProgressIndicator() : 
        Container(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return _userCard(users[index]);
            },
          )
        )
      )
    );
  }

  Card _userCard(User user) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => UserScreen(user.id)))
            .then((val) {
              _loadData();
            });
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Image(
                  image: NetworkImage(user.avatar),
                  width: 50,
                  height: 50,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(user.firstName + ' ' + user.lastName)
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _removeData(user.id);
                },
              )
            ],
          )
        ),
      )
    );
  }
}