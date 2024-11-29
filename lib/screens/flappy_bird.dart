import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FlappyBirdScreen extends StatefulWidget {
  @override
  _FlappyBirdScreenState createState() => _FlappyBirdScreenState();
}

class _FlappyBirdScreenState extends State<FlappyBirdScreen>
    with SingleTickerProviderStateMixin {
  double birdY = 0;
  double birdVelocity = 0;
  double gravity = 0.0005;
  double jumpStrength = -0.015;
  bool isGameRunning = false;
  int score = 0;

  List<double> pipeXPositions = [2, 3.5];
  double pipeWidth = 60;
  double gapHeight = 200;
  Timer? gameTimer;

  void _startGame() {
    setState(() {
      isGameRunning = true;
      birdY = 0;
      birdVelocity = 0;
      score = 0;
      pipeXPositions = [2, 3.5];
    });
    gameTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        birdVelocity += gravity;
        birdY += birdVelocity;

        for (int i = 0; i < pipeXPositions.length; i++) {
          pipeXPositions[i] -= 0.01;

          if (pipeXPositions[i] < -1.5) {
            pipeXPositions[i] = 2.5 + Random().nextDouble() * 1;
            score++;
          }

          if (pipeXPositions[i] < 0.1 && pipeXPositions[i] > -0.1) {
            double pipeTopY = -1 + Random().nextDouble() * 0.5;
            double pipeBottomY =
                pipeTopY + gapHeight / MediaQuery.of(context).size.height * 2;
            if (birdY < pipeTopY || birdY > pipeBottomY) {
              // _gameOver();
            }
          }
        }

        if (birdY > 1 || birdY < -1) {
          _gameOver();
        }
      });
    });
  }

  void _gameOver() {
    gameTimer?.cancel();
    setState(() {
      isGameRunning = false;
    });
  }

  void _jump() {
    if (!isGameRunning) {
      _startGame();
    } else {
      setState(() {
        birdVelocity = jumpStrength;
      });
    }
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
                  color: Colors.yellow,
                ),
              ),
            ),
            for (var pipeX in pipeXPositions)
              Positioned(
                left: MediaQuery.of(context).size.width * pipeX,
                top: 0,
                child: Column(
                  children: [
                    Container(
                      width: pipeWidth,
                      height: MediaQuery.of(context).size.height * 0.3,
                      color: Colors.green,
                    ),
                    SizedBox(height: gapHeight),
                    Container(
                      width: pipeWidth,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            Positioned(
              top: 30,
              left: 10,
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
