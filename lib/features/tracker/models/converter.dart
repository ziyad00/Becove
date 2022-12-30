import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampSerializer();

  @override
  DateTime fromJson(dynamic timestamp) {
    return timestamp != null ? DateTime.parse(timestamp) : DateTime.now();
  }

  @override
  String toJson(DateTime date) {
    return Timestamp.fromDate(date).toString();
  }
}
