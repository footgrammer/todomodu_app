import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/shared/types/result.dart';

abstract interface class NoticeRepository {
  Future<Result<List<Notice>>> fetchNotices();
  Future<Result<List<Notice>>> fetchNoticesbyProjectIds(List<String> projectIds);
  Future<Result<Notice>> fetchNoticebyId(String id);
}