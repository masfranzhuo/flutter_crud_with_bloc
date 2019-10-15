import 'package:flutter/material.dart';
import 'package:flutter_crud/bloc/user_bloc.dart';
import 'package:flutter_crud/models/user_model.dart';
import 'package:flutter_crud/ui/users/user.dart';
import 'package:flutter_crud/ui/users/user_form.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final UserBloc userBloc = UserBloc();

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
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserFormScreen()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          child: StreamBuilder(
              stream: userBloc.users,
              builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.length != 0
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            User user = snapshot.data[index];
                            return _userCard(user, context);
                          },
                        )
                      : Container(child: Text('No Data'));
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Card _userCard(User user, BuildContext context) {
    return Card(
        child: GestureDetector(
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserScreen(userBloc, user.id)),
        );
      },
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(padding: EdgeInsets.all(10), child: Text(user.name)),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              userBloc.deleteUser(user.id);
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text(user.name + ' deleted'))
              );
            },
          )
        ],
      )),
    ));
  }
}
