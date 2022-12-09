// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _colorAnimation;
  late Animation _sizeAnimation;
  late Animation<double> _curve;
  bool favourite = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    _controller.addListener(() {
      if (kDebugMode) {
        print(_controller.value);
      }
    });

    _controller.addStatusListener((status) {
      if (kDebugMode) {
        if (status == AnimationStatus.completed) {
          setState(() {
            favourite = true;
          });
        } else {
          setState(() {
            favourite = false;
          });
        }
      }
    });

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _colorAnimation =
        ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_curve);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 30, end: 50), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 50, end: 30), weight: 50)
    ]).animate(_curve);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return IconButton(
            icon: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: _sizeAnimation.value,
            ),
            onPressed: () {
              if (favourite) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
          );
        });
  }
}
