// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tracker/common/abstractModel.dart';

class Timer {
  String? uid;
  String? id;
  Timestamp? start;
  Timestamp? end;
  bool status;
  Timer({
    this.uid,
    this.id,
    this.start,
    this.end,
    required this.status,
  });

  Timer copyWith({
    String? uid,
    String? id,
    Timestamp? start,
    Timestamp? end,
    bool? status,
  }) {
    return Timer(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'id': id,
      'start': start,
      'end': end,
      'status': status,
    };
  }

  factory Timer.fromMap(Map<String, dynamic> map) {
    return Timer(
      uid: map['uid'] != null ? map['uid'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      start: map['start'] as Timestamp?,
      end: map['end'] as Timestamp?,
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Timer.fromJson(String source) =>
      Timer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Timer(uid: $uid, id: $id, start: $start, end: $end, status: $status)';
  }

  @override
  bool operator ==(covariant Timer other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.id == id &&
        other.start == start &&
        other.end == end &&
        other.status == status;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        id.hashCode ^
        start.hashCode ^
        end.hashCode ^
        status.hashCode;
  }
}
