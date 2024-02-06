import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  static StreamTransformer<List<T>, List<T>> transformer<T>(
    T Function(Map<String, dynamic> json) fromJson,
  ) =>
      StreamTransformer<List<T>, List<T>>.fromHandlers(
        handleData: (List<T> data, EventSink<List<T>> sink) {
          final users = data
              .map((json) => fromJson(json as Map<String, dynamic>))
              .toList();

          sink.add(users);
        },
      );

  static DateTime? toDateTime(Timestamp value) {
    // ignore: unnecessary_null_comparison
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    // ignore: unnecessary_null_comparison
    if (date == null) return null;

    return date.toUtc();
  }
}
