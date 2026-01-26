import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/logo.svg",
              height: 26,
            ),
            SizedBox(
              height: 12,
            ),
            CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
