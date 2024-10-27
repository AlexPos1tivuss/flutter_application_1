import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SpaceShooterScreen extends StatefulWidget {
  @override
  _SpaceShooterScreenState createState() => _SpaceShooterScreenState();
}

class _SpaceShooterScreenState extends State<SpaceShooterScreen> {
  double spaceshipX = 0;
  double targetX = 0;
  List<Map<String, double>> bullets = [];
  List<Map<String, double>> enemies = [];
  bool isGameRunning = false;
  Timer? gameTimer;
  int score = 0;

  void _startGame() {
    setState(() {
      isGameRunning = true;
      spaceshipX = 0;
      targetX = 0;
      bullets = [];
      enemies = [];
      score = 0;
    });

    gameTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        bullets = bullets.map((bullet) {
          return {'x': bullet['x']!, 'y': bullet['y']! + 0.02};
        }).toList();
        bullets.removeWhere((bullet) => bullet['y']! > 1);

        for (var enemy in enemies) {
          enemy['y'] = enemy['y']! + enemy['speed']!;
          if (enemy['y']! > 1) {
            _gameOver();
          }
        }
        enemies.removeWhere((enemy) => enemy['y']! > 1);

        for (int i = bullets.length - 1; i >= 0; i--) {
          for (int j = enemies.length - 1; j >= 0; j--) {
            if ((bullets[i]['x']! - enemies[j]['x']!).abs() < 0.05 &&
                (bullets[i]['y']! - enemies[j]['y']!).abs() < 0.05) {
              enemies.removeAt(j);
              bullets.removeAt(i);
              score++;
              break;
            }
          }
        }

        if ((spaceshipX - targetX).abs() > 0.01) {
          spaceshipX += (targetX - spaceshipX) * 0.1;
        }
      });
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (isGameRunning) {
        setState(() {
          bullets.add({'x': spaceshipX, 'y': 0});
        });
      }
    });

    Timer.periodic(Duration(seconds: 2), (timer) {
      if (isGameRunning) {
        setState(() {
          enemies.add({
            'x': Random().nextDouble() * 2 - 1,
            'y': -1.0,
            'speed': Random().nextDouble() * 0.01 + 0.005
          });
        });
      }
    });
  }

  void _gameOver() {
    gameTimer?.cancel();
    setState(() {
      isGameRunning = false;
    });
  }

  void _updateTargetX(double cursorX) {
    setState(() {
      targetX = (cursorX / MediaQuery.of(context).size.width) * 2 - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!isGameRunning) {
          _startGame();
        }
      },
      onPanUpdate: (details) {
        _updateTargetX(details.localPosition.dx);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              bottom: 50,
              left: MediaQuery.of(context).size.width * (0.5 + spaceshipX) - 25,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey,
              ),
            ),
            for (var bullet in bullets)
              Positioned(
                bottom: MediaQuery.of(context).size.height * bullet['y']!,
                left: MediaQuery.of(context).size.width * (0.5 + bullet['x']!) -
                    5,
                child: Container(
                  width: 10,
                  height: 20,
                  color: Colors.red,
                ),
              ),
            for (var enemy in enemies)
              Positioned(
                top: MediaQuery.of(context).size.height * enemy['y']!,
                left: MediaQuery.of(context).size.width * (0.5 + enemy['x']!),
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.green,
                ),
              ),
            Positioned(
              top: 30,
              left: 10,
              child: Text(
                'Очки: $score',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
