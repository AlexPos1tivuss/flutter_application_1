// screens/flappy_bird.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FlappyBirdScreen extends StatefulWidget {
  @override
  _FlappyBirdScreenState createState() => _FlappyBirdScreenState();
}

class _FlappyBirdScreenState extends State<FlappyBirdScreen> {
  double birdY = 0;
  double birdVelocity = 0;
  double gravity = 0.0012;
  double jumpStrength = -0.02;
  bool isGameRunning = false;
  int score = 0;

  List<double> pipeXPositions = [2, 3.5];
  double pipeWidth = 60;
  double gapHeight = 150;
  List<double> pipeGapPositions = [];
  Timer? gameTimer;

  void _startGame() {
    setState(() {
      isGameRunning = true;
      birdY = 0;
      birdVelocity = 0;
      score = 0;

      pipeXPositions = [2, 3.5];
      pipeGapPositions = [
        if (pipeGapPositions.length < pipeXPositions.length)
          ...List.generate(pipeXPositions.length, (_) => _generatePipeGap()),
      ];
    });

    gameTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        birdVelocity += gravity;
        birdY += birdVelocity;

        for (int i = 0; i < pipeXPositions.length; i++) {
          pipeXPositions[i] -= 0.01;
          if (pipeXPositions[i] < -1.5) {
            pipeXPositions[i] += 2.5;
            pipeGapPositions[i] = _generatePipeGap();
          }

          if (pipeXPositions[i] < 0 && pipeXPositions[i] > -0.01) {
            score++;
          }
        }

        if (birdY > 1 || birdY < -1 || _isBirdColliding()) {
          _gameOver();
        }
      });
    });
  }

  double _generatePipeGap() {
    return -0.4 + Random().nextDouble() * 0.8;
  }

  void _gameOver() {
    gameTimer?.cancel();
    setState(() {
      isGameRunning = false;
    });
    _showGameOverDialog();
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Проиграл"),
        content: Text("Очки: $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startGame();
            },
            child: Text("Играть снова"),
          ),
        ],
      ),
    );
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

  bool _isBirdColliding() {
    double screenHeight = MediaQuery.of(context).size.height;
    double pipeGapHeight = gapHeight / screenHeight * 2;

    for (int i = 0; i < pipeXPositions.length; i++) {
      double pipeTopY = pipeGapPositions[i];
      double pipeBottomY = pipeTopY + pipeGapHeight;

      if (pipeXPositions[i] < 0.1 && pipeXPositions[i] > -0.1) {
        if (birdY < pipeTopY || birdY > pipeBottomY) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: _jump,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: screenHeight * (0.5 + birdY),
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
            for (int i = 0; i < pipeXPositions.length; i++)
              Positioned(
                left: MediaQuery.of(context).size.width * pipeXPositions[i],
                child: Column(
                  children: [
                    Container(
                      width: pipeWidth,
                      height: screenHeight *
                          (0.5 +
                              pipeGapPositions[i] -
                              gapHeight / screenHeight),
                      color: Colors.green,
                    ),
                    SizedBox(height: gapHeight),
                    Container(
                      width: pipeWidth,
                      height: screenHeight,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            Positioned(
              top: 30,
              left: 10,
              child: Text(
                'Score: $score',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
