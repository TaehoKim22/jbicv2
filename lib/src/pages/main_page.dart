import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/models/book.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/notifiers/main_notifier.dart';
import 'package:jbicv2/src/pages/add_book_list_page.dart';
import 'package:jbicv2/src/pages/book_list_page.dart';
import 'package:jbicv2/src/pages/book_page.dart';
import 'package:jbicv2/src/pages/widgets/book_card_widget.dart';
import 'package:jbicv2/src/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:jbicv2/src/pages/widgets/book_list_card_widget.dart';

final mainPageProvider =
    ChangeNotifierProvider.family<MainNotifier, BookUser>((ref, userName) {
  final notifier = MainNotifier();
  notifier.fetchUserAndBookList(userName);
  return notifier;
});

class MainPage extends ConsumerWidget {
  final BookUser currentUser;

  const MainPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainNotifier = ref.watch(mainPageProvider(currentUser));

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 100, // Set the desired height of the bottom sheet
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ListTile(
                          onTap: () {
                            // Handle the click action (e.g., navigate to another page).
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddBookListPage(
                                        key, currentUser, true)));
                          },
                          leading: const Icon(Icons.book),
                          title: const Text('Add a book list'),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: mainNotifier.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  children: [
                    mainNotifier.userBookLists.isEmpty
                        ? const Text(
                            "You don't have any book lists yet.\nTap the + icon above to create one!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: mainNotifier.userBookLists.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookListPage(
                                                bookListId: mainNotifier
                                                    .userBookLists[index].id)));
                                  },
                                  child: BookListCard(
                                      userBookList:
                                          mainNotifier.userBookLists[index]),
                                );
                              },
                            ),
                          )
                  ],
                ),
              ));
  }
}
