import 'package:flutter/material.dart';
import 'package:flutter_crud/bloc/user_bloc.dart';
import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/ui/users/user_form.dart';

class UserScreen extends StatefulWidget {
  final int id;

  UserScreen(this.id);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserBloc userBloc;

  @override
  initState() {
    userBloc = UserBloc(id: widget.id);
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
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserFormScreen(id: widget.id)),
              );
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: userBloc.users,
            builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length != 0) {
                  User user = snapshot.data[0];
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text(user.name),
                        Text(user.username),
                        Text(user.email),
                      ],
                    )
                  );
                } else {
                  return Container(child: Text('No Data'));
                }
              } else {
                return CircularProgressIndicator();
              }
            }
          )
        ),
      )
    );
  }
}