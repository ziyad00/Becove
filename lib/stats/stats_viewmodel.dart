import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/tracker/models/timer.dart';
import 'package:tracker/tracker/tracker_repository.dart';

class StatsViewModel {
  int? calculatedTime;
  int interval = 1;
  String time = "00:00";
  void chooseInterval(BuildContext context, int? index) {
    if (index != null) {
      interval = index;
      if (interval == 0) {
        calcTime(context, 1);
      } else if (interval == 1) {
        calcTime(context, 7);
      } else if (interval == 2) {
        calcTime(context, 30);
      }
    }
  }

  void calcTime(BuildContext context, int numOfDays) async {
    // calculatedTime = 0;
    // int totalSeconds = 0;
    // List<TimerModel>? timers = await context
    //     .read<TrackerRepository>()
    //     .getAllEntriesBasedOnDate<TimerModel>('timermodel', numOfDays);

    // timers?.forEach((TimerModel timer) {
    //   totalSeconds += Timestamp.now().seconds - timer.start!.seconds;
    // });
    // calculatedTime = totalSeconds;
    // print(totalSeconds);
    // time = getDateInForm(calculatedTime);
  }

  String getDateInForm(seconds) {
    var current = seconds;
    var minutes = ((current % 3600) / 60).floor();

    var hours = (seconds / 3600).floor();
    var days = (hours / 24).floor();

    var seconds2 = current % 60;

    if (hours == 0) {
      return "${minutes}: ${seconds}";
    } else {
      return "${hours}";
    }
  }
}
