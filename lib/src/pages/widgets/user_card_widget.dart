import 'package:flutter/material.dart';
import 'package:jbicv2/src/models/book_user.dart';

class UserCard extends StatelessWidget {
  final BookUser user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: user.photoURL != null ? NetworkImage(user.photoURL!) : null,
          child: user.photoURL == null ? Text(user.userName[0]) : null,
        ),
        title: Text(user.userName),
        subtitle: Text(user.email),
      ),
    );
  }
}
