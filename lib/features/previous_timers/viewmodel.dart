import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracker/features/tracker/models/timer.dart';
import 'package:tracker/features/tracker/tracker_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviousTimersViewModel extends ChangeNotifier {
  // Let's allow the UI to add todos.

}

final Timers = StreamProvider.autoDispose<List<Timer>>((ref) {
  return TrackerRepository().getAllEntryStream();
});

final PreviousTimersProvider =
    ChangeNotifierProvider<PreviousTimersViewModel>((ref) {
  return PreviousTimersViewModel();
});
