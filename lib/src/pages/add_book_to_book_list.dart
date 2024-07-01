import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/notifiers/add_book_to_book_list_notifier.dart';
import 'package:jbicv2/src/pages/add_book_list_page.dart';
import 'package:jbicv2/src/pages/widgets/book_list_card_widget.dart';

final bookListProvider = ChangeNotifierProvider.autoDispose
    .family<AddBookToBookListNotifier, BookUser>((ref, currentBookUser) {
  final notifier = AddBookToBookListNotifier();
  notifier.fetchBookList(currentBookUser);
  return notifier;
});

class AddBookToBookList extends ConsumerWidget {
  final BookUser currentUser;
  final Book currentBook;
  AddBookToBookList(
      {super.key, required this.currentUser, required this.currentBook});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addBookToBookListNotifier = ref.watch(bookListProvider(currentUser));
    return Scaffold(
        appBar: AppBar(),
        body: addBookToBookListNotifier.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your logic for creating a new book list here
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddBookListPage(
                                    key, currentUser, false))).then(
                            (resultId) =>
                                addBookToBookListNotifier.addBookToTheList(
                                    resultId,
                                    currentBook.id,
                                    currentBook.title,
                                    currentBook.author,
                                    currentBook.isbn));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.deepPurple, // Choose your desired color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                        ),
                      ),
                      child: Text(
                        'Create a new book list',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            addBookToBookListNotifier.userBookListList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              addBookToBookListNotifier
                                  .addBookToTheList(
                                      addBookToBookListNotifier
                                          .userBookListList[index].id,
                                      currentBook.id,
                                      currentBook.title,
                                      currentBook.author,
                                      currentBook.isbn)
                                  .then((_) {
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pop(context);
                                });
                              });
                            },
                            child: BookListCard(
                                userBookList: addBookToBookListNotifier
                                    .userBookListList[index]),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ));
  }
}
