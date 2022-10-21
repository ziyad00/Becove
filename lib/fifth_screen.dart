import 'package:flutter/material.dart';
import 'package:tracker/third_screen.dart' as third_sc;

class stats extends StatelessWidget {
  const stats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        third_sc.AppBar(),
        TimeSection(),
      ],
    );
  }
}

class TimeSection extends StatelessWidget {
  const TimeSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer_rounded),
            Text("06:00 "),
          ],
        )
      ],
    );
  }
}
