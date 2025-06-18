import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/user/domain/models/user_entity.dart';

class Notification {
  String id;
  ActivityHistory activityHistory;
  DateTime dateTime;
  List<UserEntity> checkedUsers;

  Notification({
    required this.id,
    required this.activityHistory,
    required this.dateTime,
    required this.checkedUsers,
  });
}