import 'package:flutter/material.dart';
import 'screens\notes.dart';

void main() {
  runApp(GameNotesApp());
}

class GameNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    /*FlappyBirdScreen(),
    SpaceShooterScreen(),*/
    NotesScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.flight), label: 'Flappy Bird'),
          BottomNavigationBarItem(
              icon: Icon(Icons.rocket), label: 'Space Shooter'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
        ],
      ),
    );
  }
}
