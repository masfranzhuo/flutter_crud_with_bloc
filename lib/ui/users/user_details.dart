import 'package:flutter/material.dart';
import 'package:flutter_crud/bloc/user_bloc.dart';
import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/ui/users/user_form.dart';
import 'package:flutter_crud/ui/widgets/loading_widget.dart';
import 'package:flutter_crud/ui/widgets/no_data_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  final int id;

  UserDetailsScreen(this.id);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = UserBloc(id: widget.id);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('User Details'),
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
            stream: userBloc.userStream,
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (!snapshot.hasData) return Loading();
              if (snapshot.data != null) {
                User user = snapshot.data;
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
                return NoData();
              }
            }
          )
        ),
      )
    );
  }
}