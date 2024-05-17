import 'package:flutter/material.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:loading_gifs/loading_gifs.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FadeInImage.assetNetwork(
          placeholder: cupertinoActivityIndicator,
          image: 'https://covers.openlibrary.org/b/isbn/${book.isbn}-S.jpg',
        ),
        title: Text(book.title),
        subtitle: Text(book.author),
      ),
    );
  }
}