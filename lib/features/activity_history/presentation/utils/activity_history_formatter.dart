import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/models/activity_history_payload.dart';

extension ActivityHistoryMessage on ActivityHistory {
  String toReadableMessage({required String projectName}) {
    final payload = this.payload;

    switch (payload) {
      case MemberJoinedPayload(:final joinedUserId):
        return '프로젝트 $projectName에 팀원 $joinedUserId(가) 초대되었습니다.';
      case MemberLeftPayload(:final memberId):
        return '팀원 $memberId이(가) 프로젝트 $projectName에서 나갔습니다.';
      case NoticePostedPayload(:final title):
        return '공지 "$title"이(가) 등록되었습니다.';
      case TaskAddedPayload(:final title):
        return '할 일 "$title"이(가) 프로젝트 $projectName에 추가되었습니다.';
      case TaskUpdatedPayload(:final taskId):
        return '할 일 $taskId이(가) 수정되었습니다.';
      case TaskCompletedPayload(:final taskId):
        return '할 일 $taskId이(가) 완료되었습니다.';
      case TaskDeletedPayload(:final taskId):
        return '할 일 $taskId이(가) 삭제되었습니다.';
      case ProjectUpdatedPayload():
        return '프로젝트 $projectName 설정이 수정되었습니다.';
      case AssigneeAssignedPayload(:final taskId, :final assigneeId):
        return '할 일 $taskId의 담당자가 $assigneeId으로 지정되었습니다.';
      case AssigneeChangedPayload(
        :final taskId,
        :final oldAssigneeId,
        :final newAssigneeId,
      ):
        return '할 일 $taskId의 담당자가 $oldAssigneeId → $newAssigneeId로 변경되었습니다.';
      case ProjectCompletedPayload():
        return '프로젝트 $projectName이 완료되었습니다.';
      default:
        throw UnimplementedError(
          'Unhandled ActivityHistoryPayload type: $payload',
        );
    }
  }
}
