import 'package:flutter/material.dart';
import 'package:git_users/models/users.dart';
import 'package:git_users/views/userDetailsPage/user_detail.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  final Users user;
  ListItem(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(UserDetail.routeName, arguments: user),
        child: Card(
          child: ListTile(
            trailing: FutureBuilder(
              future: Provider.of<Users>(context).userNote(user.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Icon(null);
                } else {
                  return snapshot.data.length > 0
                      ? Icon(Icons.note)
                      : Icon(null);
                }
              },
            ),
            title: Text(user.login),
            subtitle: Text("${user.id}-${user.type}"),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
          ),
        ),
      ),
    );
  }
}
