import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/notice/presentation/models/notice_list_model.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

extension NoticeListModelX on NoticeListModel {
  List<Notice> get filteredNotices {
    final selectedIds = selectedProjects.map((p) => p.id).toSet();
    return notices.where((n) => selectedIds.contains(n.projectId)).toList();
  }
}

extension NoticeExtension on Notice {
  bool isUnread(UserEntity userId) {
    return !checkedUsers.contains(userId);
  }
}
