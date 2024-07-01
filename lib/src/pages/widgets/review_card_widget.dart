import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:jbicv2/src/models/review.dart';
import 'package:jbicv2/src/pages/profile_page.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Card(
        elevation: 0.0,
         color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  (review.photoURL != null)
              ? CircleAvatar(
                  backgroundImage: NetworkImage(review.photoURL!),
                )
              : CircleAvatar(
                  child: Text(review.userName[0]),
                ),
                  SizedBox(width: 8.0),
                  Text(
                    review.userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
                            RatingStars(
                value: review.rating,
                starColor: Colors.amber,
                starSize: 20.0,
                starCount: 5,
                valueLabelVisibility: false,
              ),
              SizedBox(height: 10.0,),
                            Padding(
                padding: const EdgeInsets.only(left: 3.0), // Add left margin
                child: Text(
                  review.comment,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
