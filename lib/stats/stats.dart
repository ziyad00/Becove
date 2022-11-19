import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/home/home.dart' as third_sc;
import 'package:tracker/stats/stats_viewmodel.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(),
        TimeSection(),
        TodaysTask(),
      ],
    );
  }
}

class TodaysTask extends StatelessWidget {
  const TodaysTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            "Today's Task",
            style: TextStyle(color: Color(0xFF371B34), fontSize: 22),
          ),
        ),
        third_sc.Card(
          title: "Meditation",
          body:
              "Aura is the most important thing\nthat matters to you.join us on",
          clickbait: "",
          imagePath: 'MeetupIcon',
          color: Color(0xFF14213D),
          textColor: Colors.white,
          isImage: false,
        ),
      ],
    );
  }
}

class TimeSection extends StatefulWidget {
  const TimeSection({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeSection> createState() => _TimeSectionState();
}

class _TimeSectionState extends State<TimeSection> {
  StatsViewModel? statsViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statsViewModel = context.read<StatsViewModel>();
  }

  void getStats(numOfDays) async {
    statsViewModel?.calcTime(context, numOfDays);
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/Frame.png'),
            SizedBox(
              width: 10,
            ),
            Text(
              "${statsViewModel?.time}",
              style: TextStyle(
                color: Color(0xFFFCA311),
                fontSize: 64,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Interval(
            notifyParent: refresh,
          ),
        ),
        TodaysFeeling(),
      ],
    );
  }
}

class TodaysFeeling extends StatelessWidget {
  const TodaysFeeling({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            "How are you feeling today ?",
            style: TextStyle(color: Color(0xFF371B34), fontSize: 22),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Feeling(
              feeling: "Happy",
              imagePath: "happy",
              color: Color(0xFFEF5DA8),
            ),
            Feeling(
                feeling: "Calm", imagePath: "Calm", color: Color(0xFFAEAFF7)),
            Feeling(
                feeling: "Relax", imagePath: "Relax", color: Color(0xFFF09E54)),
            Feeling(
                feeling: "Focus", imagePath: "Focus", color: Color(0xFFA0E3E2)),
          ],
        ),
      ],
    );
  }
}

class Feeling extends StatelessWidget {
  final String feeling;
  final String imagePath;
  final Color color;
  const Feeling({
    Key? key,
    required this.feeling,
    required this.imagePath,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: color,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Image.asset('images/$imagePath.png'),
          ),
        ),
        Text("$feeling"),
      ],
    );
  }
}

class AppBar extends StatefulWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  getUser() async {
    // user = await FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
          child: Image.asset('images/Hamburger.png'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
          child: user != null
              ? Image.network(
                  user!.photoURL!,
                  scale: 1.5,

                  // placeholder: (context, url) => CircularProgressIndicator(),
                  // errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : CircularProgressIndicator(),
        ),
      ],
    );
  }
}

class Interval extends StatefulWidget {
  final Function() notifyParent;

  const Interval({super.key, required this.notifyParent});

  @override
  State<Interval> createState() => _IntervalState();
}

class _IntervalState extends State<Interval> {
  List<Text> intervals = [
    Text(
      "Today",
      style: TextStyle(color: Colors.white),
    ),
    Text("7 Days"),
    Text("30 Days")
  ];
  @override
  Widget build(BuildContext context) {
    StatsViewModel statsViewModel = context.read<StatsViewModel>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color(0xFF14213D),
      ),
      width: 350,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
        child: Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                child: ChoiceChip(
                  selectedColor: Color(0xFFFCA311),
                  backgroundColor: Color(0xFF14213D),
                  label: intervals[index],
                  labelStyle: TextStyle(color: Colors.white),
                  selected: statsViewModel.interval == index,
                  onSelected: (bool selected) {
                    setState(() {
                      statsViewModel.chooseInterval(
                          context, selected ? index : null);

                      // _value = selected ? index : null;
                    });
                    widget.notifyParent();
                  },
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
