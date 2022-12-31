import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:tracker/constants/colors.dart';
import 'package:tracker/features/home/home.dart' as third_sc;
import 'package:tracker/features/stats/stats_viewmodel.dart';

import '../tracker/models/timer.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsViewModel = ref.watch(StatsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
        backgroundColor: darkBlue,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     Colors.blue,
        //     Colors.red,
        //   ],
        // )),
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            TimeSection(),
            TodaysTask(),
          ],
        ),
      ),
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
            style: TextStyle(color: lightBlue, fontSize: 22),
          ),
        ),
        third_sc.Card(
          title: "Meditation",
          body:
              "Aura is the most important thing\nthat matters to you.join us on",
          clickbait: "",
          imagePath: 'MeetupIcon',
          color: darkBlue,
          textColor: Colors.white,
          isImage: true,
          screen: "",
        ),
      ],
    );
  }
}

class TimeSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsViewModel = ref.watch(StatsViewModelProvider);
    // statsViewModel.chooseInterval(1);
    AsyncValue<List<Timer>> timers = ref.watch(timersForStats);

    return timers.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (data) {
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
                  "${statsViewModel.isFirst != true ? statsViewModel.time : statsViewModel.calcTimeBegining(1, data)} ",
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
              child: Interval(),
            ),
            TodaysFeeling(),
          ],
        );
      },
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
            style: TextStyle(color: textBlue, fontSize: 22),
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

class CustomAppBar extends ConsumerWidget {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsViewModel = ref.watch(StatsViewModelProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
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

class Interval extends ConsumerWidget {
  List<Text> intervals = [
    Text(
      "Today",
      style: TextStyle(color: Colors.white),
    ),
    Text("7 Days"),
    Text("30 Days")
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsViewModel = ref.watch(StatsViewModelProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: darkBlue,
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
                  selectedColor: orangeYellow,
                  backgroundColor: lightBlue,
                  label: intervals[index],
                  labelStyle: TextStyle(color: Colors.white),
                  selected: statsViewModel.interval == index,
                  onSelected: (bool selected) {
                    statsViewModel.chooseInterval(selected ? index : null);
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
