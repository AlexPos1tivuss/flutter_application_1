import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Инфо'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flappy bird',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Нажимая на ЛКМ по экрану, птичка прыгает. Твоя задача пролететь между труб, чтобы набирать очки. Чем больше очков, тем ты круче',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Space Battle',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Ты управляешь удержанием ЛКМ кораблем. Твоя задача, защита своей земли от инопланетного вторжения. Успехов, боец!',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Notes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Можешь отвлечься от игр и записать свои мысли после них или даже записывать свои рекорды и стратегии.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
