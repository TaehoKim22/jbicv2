import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/notifiers/post_notifier.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

final postProvider = ChangeNotifierProvider<PostNotifier>((ref){
  return PostNotifier();
});

class PostPage extends ConsumerWidget{
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
  }

  final Book book;
  final String reviewType;
  PostPage({Key? key, required this.book, required this.reviewType});
  final _controller = TextEditingController();
  final _pageController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postNotifier = ref.watch(postProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('$reviewType review for ${book.title}'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              var currentTime = DateTime.now();
              int submitRating = int.parse(_pageController.text);
              postNotifier.savePost(book, reviewType, _controller.text, submitRating, currentTime);
              dispose();
              Navigator.pop(context);
            },
            child: const Text('Submit', style: TextStyle(color: Colors.deepPurple)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            RatingStars(
              value: postNotifier.rating,
              onValueChanged: (v) {
                postNotifier.setRating(v);
              },
              starCount: 5,
              starSize: 40,
              
            ),
            if (reviewType == 'Middle') TextField(
              controller: _pageController,
              decoration: const InputDecoration(
                hintText: 'Page number',
              ),
              keyboardType: TextInputType.number,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                buildCounter: (BuildContext context, { int? currentLength, int? maxLength, bool? isFocused }) {
                  return Text(
                    '$currentLength / 1000',
                    style: TextStyle(
                      color: currentLength! > 1000 ? Colors.red : Colors.grey,
                    ),
                  );
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'What was your impression?',
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),

          ],
        ),
      ),
    );

  }
  
}