import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/notifiers/bottom_nav_notifier.dart';
import 'package:jbicv2/src/pages/main_page.dart';

final bottomNavProvider = ChangeNotifierProvider<BottomNavNotifier>((ref){
  return BottomNavNotifier();
});


class HomePage extends ConsumerWidget{
  const HomePage({super.key});
  List<Widget> _widgetOptions(String userName) => <Widget>[
    MainPage(userName: userName),
    Text('Search Page'),
    Text('Profile Page'),
  ];
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNav = ref.watch(bottomNavProvider);
    final widgetOption = _widgetOptions(bottomNav.currentUserName);
    return Scaffold(
      appBar: AppBar(),
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



}