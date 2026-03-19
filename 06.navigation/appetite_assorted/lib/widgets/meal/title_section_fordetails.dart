import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainMealDetails extends StatelessWidget {
  const MainMealDetails({
    super.key,
    required this.name,
    required this.duration,
  });

  final String name;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(children: <Widget>[durationTag(context, duration: duration)]),
    );
  }

  Widget durationTag(BuildContext context, {required int duration}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/meals/time.svg', width: 20, height: 20),
        const SizedBox(width: 10),
        Text(
          '$duration Mins recipe',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
