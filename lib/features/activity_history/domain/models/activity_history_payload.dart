import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_history_payload.freezed.dart';
part 'activity_history_payload.g.dart';

@freezed
class ActivityHistoryPayload with _$ActivityHistoryPayload {
  const ActivityHistoryPayload._(); // ✅ toJson 직접 구현을 위한 생성자

  const factory ActivityHistoryPayload.memberJoined({
    required String memberId,
    required String invitedById,
  }) = MemberJoinedPayload;

  const factory ActivityHistoryPayload.memberLeft({
    required String memberId,
  }) = MemberLeftPayload;

  const factory ActivityHistoryPayload.noticePosted({
    required String noticeId,
    required String title,
  }) = NoticePostedPayload;

  const factory ActivityHistoryPayload.taskAdded({
    required String taskId,
    required String title,
    required String creatorId,
  }) = TaskAddedPayload;

  const factory ActivityHistoryPayload.taskUpdated({
    required String taskId,
    required String updaterId,
    required Map<String, dynamic> changes,
  }) = TaskUpdatedPayload;

  const factory ActivityHistoryPayload.taskCompleted({
    required String taskId,
    required String completedById,
  }) = TaskCompletedPayload;

  const factory ActivityHistoryPayload.taskDeleted({
    required String taskId,
    required String deletedById,
  }) = TaskDeletedPayload;

  const factory ActivityHistoryPayload.projectUpdated({
    required String updaterId,
    required Map<String, dynamic> changes,
  }) = ProjectUpdatedPayload;

  const factory ActivityHistoryPayload.assigneeAssigned({
    required String taskId,
    required String assigneeId,
    required String assignedById,
  }) = AssigneeAssignedPayload;

  const factory ActivityHistoryPayload.assigneeChanged({
    required String taskId,
    required String oldAssigneeId,
    required String newAssigneeId,
    required String changedById,
  }) = AssigneeChangedPayload;

  const factory ActivityHistoryPayload.projectCompleted({
    required String completedById,
  }) = ProjectCompletedPayload;

  factory ActivityHistoryPayload.fromJson(Map<String, dynamic> json) =>
      _$ActivityHistoryPayloadFromJson(json);

  /// ✅ Freezed 3.x macro에서는 직접 위임해야 함
  @override
  Map<String, dynamic> toJson() {
    return switch (this) {
      MemberJoinedPayload() => (this as MemberJoinedPayload).toJson(),
      MemberLeftPayload() => (this as MemberLeftPayload).toJson(),
      NoticePostedPayload() => (this as NoticePostedPayload).toJson(),
      TaskAddedPayload() => (this as TaskAddedPayload).toJson(),
      TaskUpdatedPayload() => (this as TaskUpdatedPayload).toJson(),
      TaskCompletedPayload() => (this as TaskCompletedPayload).toJson(),
      TaskDeletedPayload() => (this as TaskDeletedPayload).toJson(),
      ProjectUpdatedPayload() => (this as ProjectUpdatedPayload).toJson(),
      AssigneeAssignedPayload() => (this as AssigneeAssignedPayload).toJson(),
      AssigneeChangedPayload() => (this as AssigneeChangedPayload).toJson(),
      ProjectCompletedPayload() => (this as ProjectCompletedPayload).toJson(),

    _ => throw Exception('Unhandled ActivityHistoryPayload type: $this'),
    };
  }
}
