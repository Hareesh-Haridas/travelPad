import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final int currentIndex;
  final List<Widget> screens;
  final void Function(int) onTabTapped;

  CommonLayout({
    required this.currentIndex,
    required this.screens,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        showSelectedLabels: false,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: 'Add',
              backgroundColor: Colors.teal),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
              ),
              label: 'Account',
              backgroundColor: Colors.teal)
        ],
        onTap: onTabTapped,
      ),
    );
  }
}
