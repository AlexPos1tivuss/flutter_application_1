import 'package:flutter/material.dart';

class SpaceShooterScreen extends StatefulWidget {
  @override
  _SpaceShooterScreenState createState() => _SpaceShooterScreenState();
}

class _SpaceShooterScreenState extends State<SpaceShooterScreen> {
  double spaceshipX = 0;

  void _moveLeft() {
    setState(() {
      spaceshipX -= 0.1;
    });
  }

  void _moveRight() {
    setState(() {
      spaceshipX += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
