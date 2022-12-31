import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui_auth;
import 'package:flutter/material.dart';
import 'package:tracker/constants/colors.dart';
import 'package:tracker/features/stats/stats.dart';
import 'package:tracker/features/tracker/tracker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final providers = [firebase_ui_auth.EmailAuthProvider()];

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    // TrackerScreen(),
    // StatsScreen(),
    firebase_ui_auth.ProfileScreen(
      providers: providers,
      actions: [
        firebase_ui_auth.SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/sign-in');
        }),
      ],
    )
    // Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("B E C O V E"),
        backgroundColor: darkBlue,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          // backgroundColor: Color.fromARGB(255, 80, 31, 31),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset('images/Home.png'),
              label: 'Home',
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
    return ListView(
      children: [
        // CustomAppBar(),
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Center(
        //     child: Text("B E C O V E",
        //         style: TextStyle(
        //           fontSize: 30,
        //           fontWeight: FontWeight.bold,
        //           // fontWeight: FontWeight.bold,
        //         )),
        //   ),
        // ),
        SizedBox(
          height: 15,
        ),
        Column(
          children: [
            Card(
              title: "Track your time",
              body:
                  "Let’s open up to the thing that\nmatters amoung the people ",
              clickbait: "Join Now",
              imagePath: 'MeetupIcon',
              color: orangeYellow,
              textColor: darkBlue,
              isImage: true,
              screen: "/tracker",
            ),
            Card(
              title: "See Statistics",
              body: "Time management is the most\nimportant thing that matters",
              clickbait: "Watch Now",
              imagePath: 'MeditationIcon',
              color: orangeYellow,
              textColor: darkBlue,
              isImage: true,
              screen: "/stats",
            ),
            Card(
              title: "See Previous Tracks",
              body: "Time management is the most\nimportant thing that matters",
              clickbait: "Watch Now",
              imagePath: 'MeditationIcon',
              color: orangeYellow,
              textColor: darkBlue,
              isImage: true,
              screen: "/previous_timers",
            ),
            Card(
              title: "Add Tasks",
              body: "Time management is the most\nimportant thing that matters",
              clickbait: "Watch Now",
              imagePath: 'MeditationIcon',
              color: orangeYellow,
              textColor: darkBlue,
              isImage: true,
              screen: "/home",
            ),
          ],
        ),
      ],
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
  final String screen;
  final bool isImage2 = false;
  const Card({
    Key? key,
    required this.title,
    required this.body,
    required this.clickbait,
    required this.imagePath,
    required this.color,
    required this.textColor,
    required this.isImage,
    required this.screen,
    bool? isImage2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, screen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Container(
          height: 150.0,
          width: double.infinity,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(20))),
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
                          isImage2
                              ? Image.asset('images/Vector.png')
                              : Text(""),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  isImage ? Image.asset('images/${imagePath}.png') : Text(""),
                ],
              ),
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

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  getUser() async {
    // user = FirebaseAuth.instance.currentUser;
    print(user!.photoURL!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(150, 50, 0, 0),
          child: user != null
              ? Image.network(
                  user!.photoURL!,
                  scale: 1.2,
                )
              : CircularProgressIndicator(),
        )
      ],
    );
  }
}
