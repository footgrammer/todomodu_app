import 'package:cloud_firestore/cloud_firestore.dart';

DateTime parseDate(dynamic value) {
  if (value is Timestamp) {
    return value.toDate();
  } else if (value is Map<String, dynamic> && value.containsKey('_seconds')) {
    return DateTime.fromMillisecondsSinceEpoch(
      (value['_seconds'] as int) * 1000,
    );
  } else if (value is String) {
    return DateTime.parse(value);
  } else if (value is DateTime) {
    return value;
  } else {
    throw Exception('Invalid date format: $value');
  }
}
