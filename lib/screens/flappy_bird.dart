import 'package:flutter/material.dart';

class FlappyBirdScreen extends StatefulWidget {
  @override
  _FlappyBirdScreenState createState() => _FlappyBirdScreenState();
}

class _FlappyBirdScreenState extends State<FlappyBirdScreen> {
  double birdY = 0;

  void _jump() {
    setState(() {
      birdY -= 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _jump,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * (0.5 + birdY),
              left: MediaQuery.of(context).size.width * 0.4,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Жмякай для полета!",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
