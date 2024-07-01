import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/notifiers/search_notifier.dart';
import 'package:jbicv2/src/pages/widgets/book_card_widget.dart';
import 'package:jbicv2/src/pages/widgets/user_card_widget.dart';
import '../pages/book_page.dart';



final bookSearchControllerProvider = ChangeNotifierProvider((ref) {
  return BookSearchController();
});

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = TextEditingController();
    final searchController = ref.watch(bookSearchControllerProvider);

    void _performSearch() {
      searchController.search(_controller.text);
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search...',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) => _performSearch(),
        ),
      ),
      body: ListView(
        children: <Widget>[
          if (searchController.bookResults.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Books', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ...searchController.bookResults.map((book) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookPage(bookISBN: book.isbn),
                    ),
                  );
                },
                child: BookCard(book: book),
              )),
          if (searchController.userResults.isNotEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Users', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ...searchController.userResults.map((user) => InkWell(
                onTap: () {
                  // Handle user tapped
                },
                child: UserCard(user: user),
              )),
        ],
      ),
    );
  }
}
