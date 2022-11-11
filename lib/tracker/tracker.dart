import 'package:flutter/material.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppBarTrackerScreen(),
        MiddleSection(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: ElevatedButton(
            onPressed: () {},
            child: Text("End Session"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF14213D), minimumSize: Size(350, 50)),
          ),
        ),
      ],
    );
  }
}

class MiddleSection extends StatelessWidget {
  const MiddleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Start Timer",
          style: TextStyle(fontSize: 30, color: Color(0xFF371B34)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Be Productive With Us",
          style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(.50)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: 150,
            // ),
            Image.asset('images/1.png'),
            Image.asset('images/2.png'),
            Image.asset('images/3.png'),
            Image.asset('images/4.png'),
            Image.asset('images/5.png'),
          ],
        ),
      ],
    );
  }
}

class AppBarTrackerScreen extends StatelessWidget {
  const AppBarTrackerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
          child: Icon(
            Icons.arrow_downward_rounded,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 20, 0),
          child: Image.asset('images/Ellipse 2.png'),
        ),
      ],
    );
  }
}
