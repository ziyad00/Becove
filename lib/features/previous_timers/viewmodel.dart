import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracker/features/previous_timers/previous_timer.dart';
import 'package:tracker/features/tracker/models/timer.dart';
import 'package:tracker/features/tracker/tracker_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviousTimersViewModel extends ChangeNotifier {
  bool isDay = true;
  List<Meeting> meetings = <Meeting>[];
  String selectionMode = "day";
  int interval = 2;

  String getDateInForm(seconds) {
    int sec = seconds % 60;
    int min = (sec / 60).floor();
    int hour = (min / 60).floor();
    String hours = hour.toString().length <= 1 ? "0$hour" : "$hour";

    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    final d = Duration(seconds: seconds).toString().substring(0, 7);

    return d;
  }

  void chooseInterval(int? index) {
    if (index != null) {
      interval = index;
      if (interval == 0) {
        // notifyListeners();
      } else if (interval == 1) {
        // notifyListeners();
      } else if (interval == 2) {
        // notifyListeners();
      }
    }
    notifyListeners();
  }

  void getDataSource(List<Timer> timers) {
    meetings = [];
    for (var timer in timers) {
      timer.status
          ?
          // ? meetings.add(Meeting('Timer', timer.start!.toDate(),
          //     Timestamp.now().toDate(), const Color(0xFF0F8644), false))
          null
          : meetings.add(Meeting('Timer', timer.start!.toDate(),
              timer.end!.toDate(), const Color(0xFF0F8644), false));
    }
    // notifyListeners();
  }

  void changeIsSelection() {
    isDay = !isDay;
    notifyListeners();
  }

  void addEventToCalender(List<Timer> timers, context) {
    // for (var timer in timers) {
    //   final event = timer.status
    //       ? CalendarEventData(
    //           date: timer.start!.toDate(),
    //           title: "Timer",
    //         )
    //       : CalendarEventData(
    //           date: timer.start!.toDate(),
    //           endDate: timer.end!.toDate(),
    //           title: "Timer",
    //         );
    //   CalendarControllerProvider.of(context).controller.add(event);
    // }
    // final event = CalendarEventData(
    //   date: DateTime(2022, 12, 31, 11, 11, 11),
    //   endDate: DateTime.now(),
    //   description: "_description",
    //   color: Colors.red,
    //   event: Event(title: "Ss"),
    //   title: "Event 1",
    // );

    // CalendarControllerProvider.of(context).controller.add(event);
  }
}

final Timers = StreamProvider<List<Timer>>((ref) {
  return TrackerRepository().getAllEntryStream();
});

final PreviousTimersProvider =
    ChangeNotifierProvider<PreviousTimersViewModel>((ref) {
  return PreviousTimersViewModel();
});

final TimersFuture = FutureProvider<List<Timer>>((ref) {
  return TrackerRepository().getAllEntries();
});
