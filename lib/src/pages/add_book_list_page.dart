import 'package:flutter/material.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/notifiers/add_book_list_controller.dart';
import 'package:jbicv2/src/pages/book_list_page.dart';

class AddBookListPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final BookUser user;
  final AddBookListController _addBookListController = AddBookListController();
  final bool isFromHome;

  AddBookListPage(Key? key, this.user, this.isFromHome);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Wrap the Column with Center
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically centered
          children: [
            const Text("Name Your Book List"),
            Dismissible(
              key: UniqueKey(),
              child: SizedBox(
                width: 400,
                child: TextField(
                  controller: _textController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Book List #1',
                  ),
                ),
              ),
              onDismissed: (direction) {
                // Handle dismissal (e.g., clear text field)
                _textController.clear();
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle cancel button press
                    _textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle create button press
                    String enteredText = _textController.text;
                    if (enteredText.replaceAll(' ', '').isEmpty){
                      enteredText = 'Book List #1';
                    }
                    // Do something with the entered text
                    _addBookListController
                        .createBookList(enteredText, user)
                        .then((resultId) {
                      Future.delayed(Duration(seconds: 2), () {
                        if(isFromHome){Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookListPage(bookListId: resultId)));
                        }
                        else{
                          Navigator.pop(context, resultId);
                        }
                        
                      });
                    });
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
