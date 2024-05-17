import 'package:flutter/material.dart';
import 'package:jbicv2/src/models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: (review.photoURL != null)
            ? CircleAvatar(
                backgroundImage: NetworkImage(review.photoURL!),
              )
            : CircleAvatar(
                child: Text(review.userName[0]),
              ),
        title: Text(review.userName),
        subtitle: Text(review.comment),
      ),
    );
  }
}