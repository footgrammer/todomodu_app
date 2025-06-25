// notice_extensions.dart


import 'package:todomodu_app/features/notice/domain/entities/notice.dart';

extension NoticeExtensions on Notice {
  bool isUnread(String currentUserId) {
    return !checkedUsers.any((user) => user.userId == currentUserId);
  }
}
