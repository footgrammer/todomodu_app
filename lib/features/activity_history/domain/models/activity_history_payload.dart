import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_history_payload.freezed.dart';
part 'activity_history_payload.g.dart';

@freezed
class ActivityHistoryPayload with _$ActivityHistoryPayload {
  const ActivityHistoryPayload._(); // ✅ toJson 직접 구현을 위한 생성자

  const factory ActivityHistoryPayload.memberJoined({
    required String joinedUserId,
  }) = MemberJoinedPayload;

  const factory ActivityHistoryPayload.memberLeft({
    required String memberId,
  }) = MemberLeftPayload;

  const factory ActivityHistoryPayload.noticePosted({
    required String noticeId,
    required String title,
  }) = NoticePostedPayload;

  const factory ActivityHistoryPayload.todoAdded({
    required String todoId,
    required String title,
  }) = TodoAddedPayload;

  const factory ActivityHistoryPayload.todoUpdated({
    required String todoId,
    required Map<String, dynamic> changes,
  }) = TodoUpdatedPayload;

  const factory ActivityHistoryPayload.todoCompleted({
    required String todoId,
    required String completedById,
  }) = TodoCompletedPayload;

  const factory ActivityHistoryPayload.todoDeleted({
    required String todoId,
  }) = TodoDeletedPayload;

  const factory ActivityHistoryPayload.projectUpdated({
    required String updaterId,
    required Map<String, dynamic> changes,
  }) = ProjectUpdatedPayload;

  const factory ActivityHistoryPayload.assigneeAssigned({
    required String todoId,
    required String assigneeId,
    required String assignedById,
  }) = AssigneeAssignedPayload;

  const factory ActivityHistoryPayload.assigneeChanged({
    required String todoId,
    required String oldAssigneeId,
    required String newAssigneeId,
    required String changedById,
  }) = AssigneeChangedPayload;

  const factory ActivityHistoryPayload.projectCompleted({
    required String completedById,
  }) = ProjectCompletedPayload;

  factory ActivityHistoryPayload.fromJson(Map<String, dynamic> json) =>
      _$ActivityHistoryPayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return switch (this) {
      MemberJoinedPayload() => (this as MemberJoinedPayload).toJson(),
      MemberLeftPayload() => (this as MemberLeftPayload).toJson(),
      NoticePostedPayload() => (this as NoticePostedPayload).toJson(),
      TodoAddedPayload() => (this as TodoAddedPayload).toJson(),
      TodoUpdatedPayload() => (this as TodoUpdatedPayload).toJson(),
      TodoCompletedPayload() => (this as TodoCompletedPayload).toJson(),
      TodoDeletedPayload() => (this as TodoDeletedPayload).toJson(),
      ProjectUpdatedPayload() => (this as ProjectUpdatedPayload).toJson(),
      AssigneeAssignedPayload() => (this as AssigneeAssignedPayload).toJson(),
      AssigneeChangedPayload() => (this as AssigneeChangedPayload).toJson(),
      ProjectCompletedPayload() => (this as ProjectCompletedPayload).toJson(),

      _ => throw Exception('Unhandled ActivityHistoryPayload type: $this'),
    };
  }
}
