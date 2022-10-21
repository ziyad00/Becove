import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("B E C O V E",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    // fontWeight: FontWeight.bold,
                  )),
            ),
            SettingSection(
                title: "Change Ambiance",
                subtitle:
                    "enjoy the energy of Light mode & the elegance of Dark mode"),
            BlueBox(),
            SettingSection(
                title: "Alert Settings",
                subtitle:
                    "change how frequently you would like to get alerts about your timer"),
            BlueBox(),
            Card()
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Container(
        height: 150.0,
        width: double.infinity,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFCA311),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Join our grup!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlueBox extends StatelessWidget {
  const BlueBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 50.0,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF14213D),
          ),
        ),
      ),
    );
  }
}

class SettingSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const SettingSection({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title',
              style: TextStyle(fontSize: 22, color: Color(0xFF371B34))),
          Text('$subtitle',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 13,
              )),
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Image.asset('images/Hamburger.png'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(120, 50, 0, 0),
          child: Image.asset('images/Ellipse 2.png'),
        ),
      ],
    );
  }
}
