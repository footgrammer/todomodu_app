// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberJoinedPayload _$MemberJoinedPayloadFromJson(Map<String, dynamic> json) =>
    MemberJoinedPayload(
      joinedUserId: json['joinedUserId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$MemberJoinedPayloadToJson(
  MemberJoinedPayload instance,
) => <String, dynamic>{
  'joinedUserId': instance.joinedUserId,
  'runtimeType': instance.$type,
};

MemberLeftPayload _$MemberLeftPayloadFromJson(Map<String, dynamic> json) =>
    MemberLeftPayload(
      memberId: json['memberId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$MemberLeftPayloadToJson(MemberLeftPayload instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'runtimeType': instance.$type,
    };

NoticePostedPayload _$NoticePostedPayloadFromJson(Map<String, dynamic> json) =>
    NoticePostedPayload(
      noticeId: json['noticeId'] as String,
      title: json['title'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$NoticePostedPayloadToJson(
  NoticePostedPayload instance,
) => <String, dynamic>{
  'noticeId': instance.noticeId,
  'title': instance.title,
  'runtimeType': instance.$type,
};

TodoAddedPayload _$TodoAddedPayloadFromJson(Map<String, dynamic> json) =>
    TodoAddedPayload(
      todoId: json['todoId'] as String,
      title: json['title'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TodoAddedPayloadToJson(TodoAddedPayload instance) =>
    <String, dynamic>{
      'todoId': instance.todoId,
      'title': instance.title,
      'runtimeType': instance.$type,
    };

TodoUpdatedPayload _$TodoUpdatedPayloadFromJson(Map<String, dynamic> json) =>
    TodoUpdatedPayload(
      todoId: json['todoId'] as String,
      changes: json['changes'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TodoUpdatedPayloadToJson(TodoUpdatedPayload instance) =>
    <String, dynamic>{
      'todoId': instance.todoId,
      'changes': instance.changes,
      'runtimeType': instance.$type,
    };

TodoCompletedPayload _$TodoCompletedPayloadFromJson(
  Map<String, dynamic> json,
) => TodoCompletedPayload(
  todoId: json['todoId'] as String,
  completedById: json['completedById'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TodoCompletedPayloadToJson(
  TodoCompletedPayload instance,
) => <String, dynamic>{
  'todoId': instance.todoId,
  'completedById': instance.completedById,
  'runtimeType': instance.$type,
};

TodoDeletedPayload _$TodoDeletedPayloadFromJson(Map<String, dynamic> json) =>
    TodoDeletedPayload(
      todoId: json['todoId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TodoDeletedPayloadToJson(TodoDeletedPayload instance) =>
    <String, dynamic>{'todoId': instance.todoId, 'runtimeType': instance.$type};

ProjectUpdatedPayload _$ProjectUpdatedPayloadFromJson(
  Map<String, dynamic> json,
) => ProjectUpdatedPayload(
  updaterId: json['updaterId'] as String,
  changes: json['changes'] as Map<String, dynamic>,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ProjectUpdatedPayloadToJson(
  ProjectUpdatedPayload instance,
) => <String, dynamic>{
  'updaterId': instance.updaterId,
  'changes': instance.changes,
  'runtimeType': instance.$type,
};

AssigneeAssignedPayload _$AssigneeAssignedPayloadFromJson(
  Map<String, dynamic> json,
) => AssigneeAssignedPayload(
  todoId: json['todoId'] as String,
  assigneeId: json['assigneeId'] as String,
  assignedById: json['assignedById'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$AssigneeAssignedPayloadToJson(
  AssigneeAssignedPayload instance,
) => <String, dynamic>{
  'todoId': instance.todoId,
  'assigneeId': instance.assigneeId,
  'assignedById': instance.assignedById,
  'runtimeType': instance.$type,
};

AssigneeChangedPayload _$AssigneeChangedPayloadFromJson(
  Map<String, dynamic> json,
) => AssigneeChangedPayload(
  todoId: json['todoId'] as String,
  oldAssigneeId: json['oldAssigneeId'] as String,
  newAssigneeId: json['newAssigneeId'] as String,
  changedById: json['changedById'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$AssigneeChangedPayloadToJson(
  AssigneeChangedPayload instance,
) => <String, dynamic>{
  'todoId': instance.todoId,
  'oldAssigneeId': instance.oldAssigneeId,
  'newAssigneeId': instance.newAssigneeId,
  'changedById': instance.changedById,
  'runtimeType': instance.$type,
};

ProjectCompletedPayload _$ProjectCompletedPayloadFromJson(
  Map<String, dynamic> json,
) => ProjectCompletedPayload(
  completedById: json['completedById'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ProjectCompletedPayloadToJson(
  ProjectCompletedPayload instance,
) => <String, dynamic>{
  'completedById': instance.completedById,
  'runtimeType': instance.$type,
};
