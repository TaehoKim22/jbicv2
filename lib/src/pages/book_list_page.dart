import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/notifiers/book_list_notifier.dart';
import 'package:jbicv2/src/pages/search_page.dart';
import 'package:jbicv2/src/pages/widgets/book_card_widget.dart';

final bookListProvider = ChangeNotifierProvider.autoDispose
    .family<BookListNotifier, int>((ref, bookListId) {
  final notifier = BookListNotifier();
  notifier.fetchEveryThing(bookListId);
  return notifier;
});

class BookListPage extends ConsumerWidget {
  final int bookListId;
  BookListPage({Key? key, required this.bookListId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListNotifier = ref.watch(bookListProvider(bookListId));
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
            if (bookListNotifier.currentBookUser == null)
              IconButton(
                icon: Icon(Icons.login),
                onPressed: () {
                  context.go('/start');
                },
              ),
          ],
        ),
        body: bookListNotifier.isLoading
            ? const Center(child: CircularProgressIndicator())
            : bookListNotifier.userBookList == null
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Book List Doesn\'t Exist',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red, // Customize the text color
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            bookListNotifier.userBookList!.bookListName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        bookListNotifier.booklistBooks.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Add books to the list',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle adding a book logic here
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                                      },
                                      child: Text('Search Book'),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      bookListNotifier.booklistBooks.length,
                                  itemBuilder: (context, index) {
                                    return BookCard(
                                        book: Book(
                                            id: bookListNotifier
                                                .booklistBooks[index].bookId,
                                            title: bookListNotifier
                                                .booklistBooks[index].title,
                                            author: bookListNotifier
                                                .booklistBooks[index].author,
                                            isbn: bookListNotifier
                                                .booklistBooks[index].isbn));
                                  },
                                ),
                              )
                      ]));
  }
}
