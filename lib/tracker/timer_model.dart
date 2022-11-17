import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker/common/abstractModel.dart';

class TimerModel implements Model<TimerModel> {
  final String? uid;
  final String? id;
  final Timestamp? start;
  Timestamp? end;
  bool status;

//<editor-fold desc="Data Methods">

  TimerModel({
    this.id,
    this.uid,
    this.start,
    this.end,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimerModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          start == other.start &&
          end == other.end &&
          status == other.status);

  @override
  int get hashCode =>
      uid.hashCode ^
      start.hashCode ^
      end.hashCode ^
      status.hashCode ^
      id.hashCode;

  @override
  String toString() {
    return 'Timer{' +
        ' id: $id,' +
        ' uid: $uid,' +
        ' start: $start,' +
        ' end: $end,' +
        ' status: $status,' +
        '}';
  }

  TimerModel copyWith({
    String? id,
    String? uid,
    Timestamp? start,
    Timestamp? end,
    bool? status,
  }) {
    return TimerModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      start: start ?? this.start,
      end: end ?? this.end,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'id': this.id,
      'start': this.start,
      'end': this.end,
      'status': this.status,
    };
  }

  factory TimerModel.fromMap(Map<String, dynamic> map) {
    return TimerModel(
      uid: map['uid'] as String?,
      start: map['start'] as Timestamp?,
      end: map['end'] as Timestamp?,
      status: map['status'] as bool,
    );
  }

//</editor-fold>
}
