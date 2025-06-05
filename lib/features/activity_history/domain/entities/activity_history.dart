enum ActivityType {
  notice,
  enterMember,
  exitMember,
  addTodo,
  editTodo,
  removeTodo,
  editProjectInfo,
  assignTodoManager,
  editAssignTodoManager,
  projectEnd,
}

class ActivityHistory {
  String id;
  String projectId;
  String content;
  ActivityType activityType;
  DateTime createdAt;
  ActivityHistory({
    required this.id,
    required this.projectId,
    required this.content,
    required this.activityType,
    required this.createdAt,
  });
}