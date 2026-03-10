import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class mealMainMdetail extends StatelessWidget {
  final int duration;
  final String name;

  const mealMainMdetail({
    required this.duration,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: <Widget>[
          durationTag(context, duration: duration),
        ],
      ),
    );
  }

  Container durationTag(BuildContext context, {required int duration}) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/meals/time.svg",
            width: 20,
            height: 20,
          ),
          SizedBox(width: 10),
          Text(
            "$duration Mins recipe",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
