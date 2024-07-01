import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:jbicv2/src/models/review.dart';
import 'package:jbicv2/src/notifiers/book_notifier.dart';
import 'package:animated_expandable_fab/animated_expandable_fab.dart';
import 'package:jbicv2/src/pages/add_book_to_book_list.dart';
import 'package:jbicv2/src/pages/post_page.dart';
import 'package:jbicv2/src/pages/widgets/review_card_widget.dart';
import 'package:loading_gifs/loading_gifs.dart';

final bookProvider = ChangeNotifierProvider.autoDispose
    .family<BookNotifier, String>((ref, bookISBN) {
  final notifier = BookNotifier();
  notifier.fetchBook(bookISBN);
  notifier.fetchBookReviews(bookISBN);
  return notifier;
});

const List<String> reviewType = <String>['Cover', 'Middle', 'Final'];

class BookPage extends ConsumerWidget {
  final String bookISBN;
  BookPage({Key? key, required this.bookISBN});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookNotifier = ref.watch(bookProvider(bookISBN));
    if (bookNotifier.isLoading || bookNotifier.book == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      if (bookNotifier.book?.isbn == "isbn") {
        return const Center(child: Text("Wrong ISBN"));
      } else {
        final tabs = [
          bookNotifier.bookUser != null ? 'Other Reviews' : 'Reviews'
        ];
        final tabViews = [_buildSecondaryTab(tabs[0], bookNotifier)];

        if (bookNotifier.bookUser != null) {
          tabs.insert(0, 'My Review');
          tabViews.insert(0, _buildSecondaryTab('My Review', bookNotifier));
        }

        return Scaffold(
          appBar: AppBar(
            title: kIsWeb
                ? GestureDetector(
                    onTap: () {
                      context.go('/home');
                    },
                    child: const Text('JBIC', textAlign: TextAlign.center),
                  )
                : null, // Your usual title for non-web platforms
            actions: [
              if (bookNotifier.bookUser == null)
                IconButton(
                  icon: Icon(Icons.login),
                  onPressed: () {
                    context.go('/start');
                  },
                ),
            ],
          ),
          floatingActionButton: Visibility(
            visible: bookNotifier.bookUser != null,
            child: ExpandableFab(
              distance: 100,
              openIcon: const Icon(Icons.add),
              closeIcon: const Icon(Icons.close),
              children: [
                ActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostPage(
                              reviewType: 'Cover', book: bookNotifier.book!)),
                    ).then((_) {
                      Fluttertoast.showToast(
                          msg: "Posting",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Future.delayed(Duration(seconds: 2), () {
                        // Fetch book reviews here
                        bookNotifier.fetchBookReviews(bookISBN);
                        Fluttertoast.showToast(
                            msg: "Posted!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    });
                  },
                  icon: Icon(Icons.add),
                  text: Text("Cover\t"),
                ),
                ActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostPage(
                              reviewType: 'Middle', book: bookNotifier.book!)),
                    ).then((_) {
                      Fluttertoast.showToast(
                          msg: "Posting",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Future.delayed(Duration(seconds: 2), () {
                        // Fetch book reviews here
                        bookNotifier.fetchBookReviews(bookISBN);
                        Fluttertoast.showToast(
                            msg: "Posted!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    });
                  },
                  icon: Icon(Icons.add),
                  text: Text("Middle\t"),
                ),
                ActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostPage(
                              reviewType: 'Final', book: bookNotifier.book!)),
                    ).then((_) {
                      Fluttertoast.showToast(
                          msg: "Posting...",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Future.delayed(Duration(seconds: 2), () {
                        // Fetch book reviews here
                        bookNotifier.fetchBookReviews(bookISBN);
                        Fluttertoast.showToast(
                            msg: "Posted!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                    });
                  },
                  icon: Icon(Icons.add),
                  text: Text("Final\t"),
                ),
              ],
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  bookNotifier.book!.title,
                ),
                Text(
                  bookNotifier.book!.author,
                ),
                FadeInImage.assetNetwork(
                    placeholder: cupertinoActivityIndicator,
                    image:
                        'https://covers.openlibrary.org/b/isbn/${bookNotifier.book!.isbn}-M.jpg'),
                Visibility(
                  visible: bookNotifier.bookUser != null,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddBookToBookList(currentUser: bookNotifier.bookUser!, currentBook: bookNotifier.book!,)));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(
                          8.0), // Add some padding for better tap area
                      child: Text(
                        'Add to Booklist',
                        style: TextStyle(
                          color: Colors.deepPurple, // Customize the text color
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: DefaultTabController(
                    length: tabs.length,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: tabViews,
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
    }
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
                List<Review?> reviews = [];
                if (type == 'My Review') {
                  if (reviewType == 'Cover')
                    reviews = notifier.coverMyReviewList;
                  else if (reviewType == 'Middle')
                    reviews = notifier.middleMyReviewList;
                  else if (reviewType == 'Final')
                    reviews = notifier.finalMyReviewList;
                } else {
                  if (reviewType == 'Cover')
                    reviews = notifier.coverOtherReviewList;
                  else if (reviewType == 'Middle')
                    reviews = notifier.middleOtherReviewList;
                  else if (reviewType == 'Final')
                    reviews = notifier.finalOtherReviewList;
                }
                return ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewCard(review: reviews[index]!);
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
