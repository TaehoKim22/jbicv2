import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/notifiers/bottom_nav_notifier.dart';
import 'package:jbicv2/src/pages/main_page.dart';
import 'package:jbicv2/src/pages/profile_page.dart';
import 'package:jbicv2/src/pages/search_page.dart';
import 'package:jbicv2/src/pages/start_page.dart';

final bottomNavProvider =
    ChangeNotifierProvider.autoDispose<BottomNavNotifier>((ref) {
  final notifier =  BottomNavNotifier();
  notifier.initializeUserName();
  return notifier;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  List<Widget> _widgetOptions(BookUser currentUser) => <Widget>[
        MainPage(currentUser: currentUser),
        SearchPage(),
        ProfilePage(userId: currentUser.id),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNav = ref.watch(bottomNavProvider);

    if (bottomNav.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if(bottomNav.currentBookUser == null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage()));
      }
      else{
      final widgetOption = _widgetOptions(bottomNav.currentBookUser!);
      return Scaffold(
        body: widgetOption.elementAt(bottomNav.wIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
             BottomNavigationBarItem(
               icon: Icon(Icons.person),
               label: 'Profile',
             ),
          ],
          currentIndex: bottomNav.wIndex,
          selectedItemColor: Colors.deepPurple,
          onTap: bottomNav.setIndex,
        ),
      );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
