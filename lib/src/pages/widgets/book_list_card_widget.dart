import 'package:flutter/material.dart';
import 'package:jbicv2/src/models/user_book_list.dart';

class BookListCard extends StatelessWidget {
  final UserBookList userBookList;

  const BookListCard({Key? key, required this.userBookList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent, // This makes the card transparent
      elevation: 0.0, // This removes the shadow
      child: ListTile(
        leading: ClipRRect(// Adjust the radius as needed
  child: Container(
    height: 70.0,
    width: 70.0,
    color: Colors.deepPurple, // Customize the background color
    child: userBookList.photoURL != null
        ? Image.network(userBookList.photoURL!)
        : Center(child: Text(userBookList.bookListName[0], style: TextStyle(color: Colors.white))),
  ),
),
        title: Text(userBookList.bookListName,),
      ),
    );
  }
}
