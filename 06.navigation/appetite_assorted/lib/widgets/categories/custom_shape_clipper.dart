import 'package:flutter/material.dart';

enum ClipType { semiCircle, halfCircle }

class CustomShapeClipper extends CustomClipper<Path> {
  const CustomShapeClipper(this.clipType, {this.borderRadius});

  final ClipType clipType;
  final BorderRadius? borderRadius;

  @override
  Path getClip(Size size) {
    final path = Path();

    switch (clipType) {
      case ClipType.semiCircle:
        _buildSemiCircle(path, size);
      case ClipType.halfCircle:
        _buildHalfCircle(path, size);
    }

    return path..close();
  }

  void _buildSemiCircle(Path path, Size size) {
    final br = borderRadius;

    if (br?.topLeft != Radius.zero && br?.topLeft != null) {
      final r = br!.topLeft.x;
      path.moveTo(r, 0);
    } else {
      path.moveTo(0, 0);
    }

    if (br?.topRight != Radius.zero && br?.topRight != null) {
      final r = br!.topRight.x;
      path.lineTo(size.width / 1.40 - r, 0);
      path.quadraticBezierTo(size.width / 1.40, 0, size.width / 1.40, r);
    } else {
      path.lineTo(size.width / 1.40, 0);
    }

    path.quadraticBezierTo(
      size.width / 1.30,
      size.height / 2.5,
      size.width / 1.85,
      size.height / 1.85,
    );

    path.quadraticBezierTo(
      size.width / 4,
      size.height / 1.45,
      0,
      size.height / 1.75,
    );

    if (br?.bottomLeft != Radius.zero && br?.bottomLeft != null) {
      final r = br!.bottomLeft.x;
      path.lineTo(0, size.height / 1.75);
      path.quadraticBezierTo(
        0,
        size.height / 1.75 + r,
        r,
        size.height / 1.75 + r,
      );
    }

    if (br?.topLeft != Radius.zero && br?.topLeft != null) {
      final r = br!.topLeft.x;
      path.lineTo(0, r);
      path.quadraticBezierTo(0, 0, r, 0);
    } else {
      path.lineTo(0, 0);
    }
  }

  void _buildHalfCircle(Path path, Size size) {
    final br = borderRadius;

    if (br?.topLeft != Radius.zero && br?.topLeft != null) {
      final r = br!.topLeft.x;
      path.moveTo(r, 0);
    } else {
      path.moveTo(0, 0);
    }

    if (br?.topRight != Radius.zero && br?.topRight != null) {
      final r = br!.topRight.x;
      path.lineTo(size.width / 2 - r, 0);
      path.quadraticBezierTo(size.width / 2, 0, size.width / 2, r);
    } else {
      path.lineTo(size.width / 2, 0);
    }

    path.quadraticBezierTo(
      size.width / 1.10,
      size.height / 2,
      size.width / 2,
      size.height,
    );

    if (br?.bottomLeft != Radius.zero && br?.bottomLeft != null) {
      final r = br!.bottomLeft.x;
      path.lineTo(r, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - r);
    } else {
      path.lineTo(0, size.height);
    }

    if (br?.topLeft != Radius.zero && br?.topLeft != null) {
      final r = br!.topLeft.x;
      path.lineTo(0, r);
      path.quadraticBezierTo(0, 0, r, 0);
    }
  }

  @override
  bool shouldReclip(CustomShapeClipper oldClipper) {
    return oldClipper.clipType != clipType ||
        oldClipper.borderRadius != borderRadius;
  }
}
