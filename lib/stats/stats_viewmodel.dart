import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/tracker/models/timer.dart';
import 'package:tracker/tracker/tracker_repository.dart';

class StatsViewModel extends ChangeNotifier {
  int? calculatedTime;
  int interval = 1;
  bool isFirst = true;
  String? time = "00:00";
  void chooseInterval(int? index) {
    if (index != null) {
      interval = index;
      if (interval == 0) {
        calcTime(1);
        notifyListeners();
      } else if (interval == 1) {
        calcTime(7);
        notifyListeners();
      } else if (interval == 2) {
        calcTime(30);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  String chooseIntervalBegining(int? index, timers) {
    if (index != null) {
      interval = index;
      if (interval == 0) {
        return calcTimeBegining(1, timers);
      } else if (interval == 1) {
        return calcTimeBegining(7, timers);
      } else if (interval == 2) {
        return calcTimeBegining(30, timers);
      }
    }
    return "00:00:00";
    notifyListeners();
  }

  String calcTimeBegining(int numOfDays, timers) {
    calculatedTime = 0;
    int totalSeconds = 0;
    isFirst = false;

    timers?.forEach((Timer timer) {
      if (timer.end != null)
        totalSeconds += timer.end!.seconds - timer.start!.seconds;
    });
    calculatedTime = totalSeconds;
    print(totalSeconds);
    final timeInFormat = getDateInForm(calculatedTime);
    return timeInFormat;
  }

  void calcTime(int numOfDays) async {
    calculatedTime = 0;
    int totalSeconds = 0;
    List<Timer>? timers =
        await TrackerRepository().getAllEntriesBasedOnDate(numOfDays);

    timers?.forEach((Timer timer) {
      if (timer.end != null)
        totalSeconds += timer.end!.seconds - timer.start!.seconds;
    });
    calculatedTime = totalSeconds;
    print(totalSeconds);
    time = getDateInForm(calculatedTime);
    notifyListeners();
  }

  String getDateInForm(seconds) {
    int sec = seconds % 60;
    int min = (sec / 60).floor();
    int hour = (min / 60).floor();
    String hours = hour.toString().length <= 1 ? "0$hour" : "$hour";

    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    final d = Duration(seconds: seconds).toString().substring(0, 7);

    return d;
    notifyListeners();
  }
}

final StatsViewModelProvider = ChangeNotifierProvider<StatsViewModel>((ref) {
  return StatsViewModel();
});

final timersForStats = FutureProvider<List<Timer>>((ref) async {
  return TrackerRepository().getAllEntriesBasedOnDate(1);
});
