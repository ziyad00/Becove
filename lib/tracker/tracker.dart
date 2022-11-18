import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/tracker/timer_model.dart';
import 'package:tracker/tracker/tracker_repository.dart';

class TrackerScreen extends StatefulWidget {
  TrackerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  void initState() {
    super.initState();
  }

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

class MiddleSection extends StatefulWidget {
  MiddleSection({
    Key? key,
  }) : super(key: key);

  @override
  State<MiddleSection> createState() => _MiddleSectionState();
}

class _MiddleSectionState extends State<MiddleSection> {
  TimerModel timer = TimerModel(status: false);

  add() async {
    await context.read<TrackerRepository>().addEntryWithAutogeneratedId(
        TimerModel(status: true, start: Timestamp.now()));
    timer = await context.read<TrackerRepository>().getLastEntry();
    setState(() {});
  }

  void get() async {
    timer = await context.read<TrackerRepository>().getLastEntry();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  getDateInForm(seconds) {
    var current = seconds;
    var hours = (current / 3600).floor();
    var minutes = ((current % 3600) / 60).floor();
    var seconds2 = current % 60;
    if (hours == 0) {
      return "${minutes}:${seconds2}";
    } else {
      return "${hours}:${minutes}:${seconds2}";
    }
  }

  Stream<String> calcTimerPeriodically(DateTime date) async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      final DateTime now = DateTime.now();
      a = now.difference(date).inSeconds;
      return getDateInForm(a);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        timer.status
            ? StreamBuilder(
                initialData: "loading",
                stream: calcTimerPeriodically(timer.start!.toDate()),
                builder: (context, snapshot) {
                  return Text(
                    "${snapshot.data.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, color: Color(0xFF371B34)),
                  );
                },
              )
            : Text(""),
        SizedBox(
          height: 10,
        ),
        // Text(
        //   "${getDateHourly(Timestamp.now().seconds - timer.start!.seconds)}",
        //   style: TextStyle(fontSize: 30, color: Color(0xFF371B34)),
        // ),
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

            GestureDetector(
              child: timer.status
                  ? Icon(
                      Icons.stop_circle,
                      size: 80,
                    )
                  : Icon(
                      Icons.play_circle,
                      size: 80,
                    ),
              onTap: () {
                if (!timer.status) {
                  context.read<TrackerRepository>().addEntryWithAutogeneratedId(
                      TimerModel(status: true, start: Timestamp.now()));
                  add();
                  setState() {}
                } else {
                  timer.end = Timestamp.now();
                  timer.status = false;
                  context.read<TrackerRepository>().updateEntryWithId(timer);
                  setState(() {});
                }
                // trackerRepo.addEntryWithAutogeneratedId<TimerModel>(TimerModel(
                //     uid: "1", start: Timestamp.now(), status: false));
              },
            ),
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
