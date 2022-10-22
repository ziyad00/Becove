import 'package:flutter/material.dart';
import 'package:tracker/fifth_screen.dart';
import 'package:tracker/forth_screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Tracker(),
    stats(),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('images/Home.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/RectangleCopy3.png'),
            label: 'Tracker',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/noun_users_847316 2.png'),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/settings.png'),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  title: "Join our grup!",
                  body:
                      "Let’s open up to the thing that\nmatters amoung the people ",
                  clickbait: "Join Now",
                  imagePath: 'MeetupIcon',
                  color: Color(0xFFFCA311),
                  textColor: Color(0xFF371B34),
                  isImage: true,
                ),
                Card(
                  title: "Chat with us!",
                  body:
                      "Time management is the most\nimportant thing that matters\nFeel free to ask us for tips&tricks",
                  clickbait: "Watch Now",
                  imagePath: 'MeditationIcon',
                  color: Color(0xFFFCA311),
                  textColor: Color(0xFF371B34),
                  isImage: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String title;
  final String body;
  final String clickbait;
  final String imagePath;
  final Color color;
  final Color textColor;
  final bool isImage;
  const Card({
    Key? key,
    required this.title,
    required this.body,
    required this.clickbait,
    required this.imagePath,
    required this.color,
    required this.textColor,
    required this.isImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        height: 150.0,
        width: double.infinity,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$title",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        )),
                    Text(
                      "$body",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      softWrap: true,
                    ),
                    Row(
                      children: [
                        Text(
                          "$clickbait",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        isImage ? Image.asset('images/Vector.png') : Text(""),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
                Image.asset('images/${imagePath}.png'),
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
