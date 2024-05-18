import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/notifiers/main_notifier.dart';
import 'package:jbicv2/src/pages/book_page.dart';
import 'package:jbicv2/src/pages/widgets/book_card_widget.dart';

final mainPageProvider = ChangeNotifierProvider.family<MainNotifier, String>((ref, userName) {
  final notifier = MainNotifier();
  notifier.fetchUserAndBookList(userName);
  return notifier;
});


class MainPage extends ConsumerWidget {
  final String userName;

  const MainPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainNotifier = ref.watch(mainPageProvider(userName));

    return Scaffold(
      body: mainNotifier.isLoading
          ? Center(child: CircularProgressIndicator())
          : mainNotifier.userBookList == null || mainNotifier.userBookList!.bookList!.isEmpty
            ? const Center(child: Text('Add a book to the list'))
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'My List',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: mainNotifier.userBookList?.bookList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookPage(book: mainNotifier.userBookList!.bookList![index]),
                              )
                            );
                          },
                          child: BookCard(book: mainNotifier.userBookList!.bookList![index]),
                        );
                      },
                    ),
                  )
               ]
              )
      );
  }
}
