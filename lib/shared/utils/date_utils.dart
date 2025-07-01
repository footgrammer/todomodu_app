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

String timeAgo(DateTime date) {
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inMinutes < 1) return '방금 전';
  if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
  if (diff.inHours < 24) return '${diff.inHours}시간 전';
  if (diff.inDays == 1) return '어제';
  return '${diff.inDays}일 전';
}

