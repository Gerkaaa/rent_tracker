import 'package:flutter/material.dart';
import 'package:rent_tracker/presentation/daily_screen/daily_screen.dart';
import 'package:rent_tracker/presentation/long_term_screen/long_term_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[LongTermScreen(), DailyScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 65,
        backgroundColor: const Color(0xFFF3F4F9),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            label: 'Долгий срок кв',
            icon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'Посуточные кв',
            icon: Icon(Icons.calendar_today),
          ),
        ],
      ),
    );
  }
}
