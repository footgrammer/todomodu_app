// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberJoinedPayload _$MemberJoinedPayloadFromJson(Map<String, dynamic> json) =>
    MemberJoinedPayload(
      memberId: json['memberId'] as String,
      invitedById: json['invitedById'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$MemberJoinedPayloadToJson(
  MemberJoinedPayload instance,
) => <String, dynamic>{
  'memberId': instance.memberId,
  'invitedById': instance.invitedById,
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

TaskAddedPayload _$TaskAddedPayloadFromJson(Map<String, dynamic> json) =>
    TaskAddedPayload(
      taskId: json['taskId'] as String,
      title: json['title'] as String,
      creatorId: json['creatorId'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TaskAddedPayloadToJson(TaskAddedPayload instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'title': instance.title,
      'creatorId': instance.creatorId,
      'runtimeType': instance.$type,
    };

TaskUpdatedPayload _$TaskUpdatedPayloadFromJson(Map<String, dynamic> json) =>
    TaskUpdatedPayload(
      taskId: json['taskId'] as String,
      updaterId: json['updaterId'] as String,
      changes: json['changes'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TaskUpdatedPayloadToJson(TaskUpdatedPayload instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'updaterId': instance.updaterId,
      'changes': instance.changes,
      'runtimeType': instance.$type,
    };

TaskCompletedPayload _$TaskCompletedPayloadFromJson(
  Map<String, dynamic> json,
) => TaskCompletedPayload(
  taskId: json['taskId'] as String,
  completedById: json['completedById'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TaskCompletedPayloadToJson(
  TaskCompletedPayload instance,
) => <String, dynamic>{
  'taskId': instance.taskId,
  'completedById': instance.completedById,
  'runtimeType': instance.$type,
};

TaskDeletedPayload _$TaskDeletedPayloadFromJson(Map<String, dynamic> json) =>
    TaskDeletedPayload(
      taskId: json['taskId'] as String,
      deletedById: json['deletedById'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TaskDeletedPayloadToJson(TaskDeletedPayload instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'deletedById': instance.deletedById,
      'runtimeType': instance.$type,
    };

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
  taskId: json['taskId'] as String,
  assigneeId: json['assigneeId'] as String,
  assignedById: json['assignedById'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$AssigneeAssignedPayloadToJson(
  AssigneeAssignedPayload instance,
) => <String, dynamic>{
  'taskId': instance.taskId,
  'assigneeId': instance.assigneeId,
  'assignedById': instance.assignedById,
  'runtimeType': instance.$type,
};

AssigneeChangedPayload _$AssigneeChangedPayloadFromJson(
  Map<String, dynamic> json,
) => AssigneeChangedPayload(
  taskId: json['taskId'] as String,
  oldAssigneeId: json['oldAssigneeId'] as String,
  newAssigneeId: json['newAssigneeId'] as String,
  changedById: json['changedById'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$AssigneeChangedPayloadToJson(
  AssigneeChangedPayload instance,
) => <String, dynamic>{
  'taskId': instance.taskId,
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
