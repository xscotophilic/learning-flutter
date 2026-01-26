import 'package:flutter/material.dart';

import '../../../const.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(
              Constants.kDefaultPaddin,
            ),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}
