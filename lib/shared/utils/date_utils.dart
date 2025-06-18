import 'package:intl/intl.dart';

String formatDateYMD(DateTime? date) {
  if (date == null) return '';
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatKoreanDate(DateTime? date) {
  if (date == null) return '';
  return DateFormat('yyyy년 MM월 dd일', 'ko').format(date);
}
