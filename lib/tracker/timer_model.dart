import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker/tracker/abstractModel.dart';

class Timer implements AbstractModel {
  final String uid;
  final Timestamp start;
  final Timestamp? end;
  final bool status;

//<editor-fold desc="Data Methods">

  const Timer({
    required this.uid,
    required this.start,
    this.end,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Timer &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          start == other.start &&
          end == other.end &&
          status == other.status);

  @override
  int get hashCode =>
      uid.hashCode ^ start.hashCode ^ end.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'Timer{' +
        ' uid: $uid,' +
        ' start: $start,' +
        ' end: $end,' +
        ' status: $status,' +
        '}';
  }

  Timer copyWith({
    String? uid,
    Timestamp? start,
    Timestamp? end,
    bool? status,
  }) {
    return Timer(
      uid: uid ?? this.uid,
      start: start ?? this.start,
      end: end ?? this.end,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'start': this.start,
      'end': this.end,
      'status': this.status,
    };
  }

  factory Timer.fromMap(Map<String, dynamic> map) {
    return Timer(
      uid: map['uid'] as String,
      start: map['start'] as Timestamp,
      end: map['end'] as Timestamp,
      status: map['status'] as bool,
    );
  }

//</editor-fold>
}
