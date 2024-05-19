import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/review.dart';
import 'package:jbicv2/src/notifiers/book_notifier.dart';
import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:jbicv2/src/pages/post_page.dart';
import 'package:jbicv2/src/pages/widgets/review_card_widget.dart';
import 'package:loading_gifs/loading_gifs.dart';


final bookProvider = ChangeNotifierProvider.family<BookNotifier, Book>((ref, book){
  final notifier = BookNotifier();
  notifier.fetchBookReviews(book.id);
  return notifier;
});

const List<String> reviewType = <String>['Cover', 'Middle', 'Final'];

class BookPage extends ConsumerWidget{
  final Book book;
  const BookPage({Key? key, required this.book}) :super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final bookNotifier = ref.watch(bookProvider(book));
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: ExpandableFab(
          distance: 100,
          openIcon: const Icon(Icons.add),
          closeIcon: const Icon(Icons.close),
          children: [
              ActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostPage(reviewType: 'Cover', book: book)),
                  );
                }, 
                icon: Icon(Icons.add),
                text: Text("Cover\t"),
              ),
              ActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostPage(reviewType: 'Middle', book: book)),
                  );
                }, 
                icon: Icon(Icons.add),
                text: Text("Middle\t"),
              ),
              ActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostPage(reviewType: 'Final', book: book)),
                  );
                }, 
                icon: Icon(Icons.add),
                text: Text("Final\t"),
              ),
          ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              book.title,
            ),
            Text(
              book.author,
            ),
            FadeInImage.assetNetwork(placeholder: cupertinoActivityIndicator, image: 'https://covers.openlibrary.org/b/isbn/${book.isbn}-M.jpg'),
            Flexible(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    const TabBar(
                      tabs: [
                        Tab(text: 'My Review'),
                        Tab(text: 'Other Reviews'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildSecondaryTab('My Review', bookNotifier), // Add secondary tab under 'My Review'
                          _buildSecondaryTab('Other Reviews', bookNotifier), // Add secondary tab under 'Other Reviews'
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildSecondaryTab(String type, BookNotifier notifier) {
  return DefaultTabController(
    length: reviewType.length,
    child: Column(
      children: <Widget>[
        TabBar(
          tabs: reviewType.map((type) => Tab(text: type)).toList(),
        ),
        Expanded(
          child: TabBarView(
            children: reviewType.map((reviewType) {
              List<Review> reviews = [];
              if (type == 'My Review') {
                if (reviewType == 'Cover') reviews = notifier.coverMyReviewList;
                else if (reviewType == 'Middle') reviews = notifier.middleMyReviewList;
                else if (reviewType == 'Final') reviews = notifier.finalMyReviewList;
              } else {
                if (reviewType == 'Cover') reviews = notifier.coverOtherReviewList;
                else if (reviewType == 'Middle') reviews = notifier.middleOtherReviewList;
                else if (reviewType == 'Final') reviews = notifier.finalOtherReviewList;
              }
              return ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return ReviewCard(review: reviews[index]);
                },
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

}