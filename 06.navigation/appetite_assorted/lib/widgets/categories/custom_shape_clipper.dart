import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ClipType { semiCircle, halfCircle }

class CustomShapeClipper extends CustomClipper<Path> {
  const CustomShapeClipper(this.clipType);

  final ClipType clipType;

  @override
  getClip(Size size) {
    var path = Path();
    if (clipType == ClipType.semiCircle) {
      createSemiCirle(size, path);
    } else if (clipType == ClipType.halfCircle) {
      createHalfCircle(size, path);
    }
    path.close();
    return path;
  }

  void createSemiCirle(Size size, Path path) {
    path.lineTo(size.width / 1.40, 0);

    var firstControlPoint = Offset(size.width / 1.30, size.height / 2.5);
    var firstEndPoint = Offset(size.width / 1.85, size.height / 1.85);

    var secondControlPoint = Offset(size.width / 4, size.height / 1.45);
    var secondEndPoint = Offset(0, size.height / 1.75);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(0, size.height / 1.75);
  }

  void createBottom(Size size, Path path) {
    path.lineTo(0, size.height / 1.19);
    var secondControlPoint = Offset((size.width / 2), size.height);
    var secondEndPoint = Offset(size.width, size.height / 1.19);

    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, 0);
  }

  void createHalfCircle(Size size, Path path) {
    path.lineTo(size.width / 2, 0);
    var firstControlPoint = Offset(size.width / 1.10, size.height / 2);
    var firstEndPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.lineTo(0, size.height);
  }

  void createMultiple(Size size, Path path) {
    path.lineTo(0, size.height);

    var curXPos = 0.0;
    var curYPos = size.height;
    Random rnd = Random();

    var increment = size.width / 40;
    while (curXPos < size.width) {
      curXPos += increment;
      curYPos = curYPos == size.height
          ? size.height - rnd.nextInt(50 - 0)
          : size.height;
      path.lineTo(curXPos, curYPos);
    }
    path.lineTo(size.width, 0);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
