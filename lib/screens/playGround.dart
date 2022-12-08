import 'dart:math';

import 'package:flutter/material.dart';

class MyPlayGround extends StatefulWidget {
  const MyPlayGround({super.key});

  @override
  State<MyPlayGround> createState() => _MyPlayGroundState();
}

class _MyPlayGroundState extends State<MyPlayGround> {
  double _width = 200;
  double _opacity = 1;
  Color _color = Colors.blue;
  Color _colort = Colors.red;
  double _margin = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.all(_margin),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [_color, _colort]),
        ),
        width: (_width),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              width: 20,
            ),
            ElevatedButton(
              onPressed: (() {
                setState(() {
                  _margin = Random().nextDouble() * 150;
                });
              }),
              child: const Text("Change Margin"),
            ),
            ElevatedButton(
              onPressed: (() {
                setState(() {
                  _color = _colort;
                  _colort = Colors
                      .primaries[Random().nextInt(Colors.primaries.length)];
                });
              }),
              child: const Text("Change Color"),
            ),
            ElevatedButton(
              onPressed: (() {
                setState(() {
                  _width = Random().nextDouble() * 300;
                });
              }),
              child: const Text("Change Width"),
            )
          ],
        ),
      ),
    );
  }
}
