import 'package:intl/intl.dart';

String formatDateYMD(DateTime? date) {
  if (date == null) return '';
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatKoreanDate(DateTime? date) {
  if (date == null) return '';
  return DateFormat('yyyy년 MM월 dd일', 'ko').format(date);
}

String formatKoreanMonthDate(DateTime? date) {
  if (date == null) return '';
  return DateFormat('M월 d일', 'ko').format(date);
}

String formatDateDottedYMD(DateTime? date) {
  if (date == null) return '';
  return DateFormat('yyyy.MM.dd').format(date);
}
