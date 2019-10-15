import 'package:flutter/material.dart';
import 'package:flutter_crud/bloc/user_bloc.dart';

class UserScreen extends StatefulWidget {
  final UserBloc userBloc;
  final int id;

  UserScreen(this.userBloc, this.id);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
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
              // Navigator.of(context)
              //   .push(MaterialPageRoute(builder: (_) => UserFormScreen(widget.id, user)))
              //   .then((val) {
              //     _loadData();
              //   });
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Text('WIP '+widget.id.toString()),
              ],
            )
          )
        ),
      )
    );
  }
}