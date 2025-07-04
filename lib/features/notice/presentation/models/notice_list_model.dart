import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';
import 'package:todomodu_app/features/user/domain/entities/user_entity.dart';

class NoticeListModel {
  final List<Notice> notices;
  final List<SimpleProjectInfo> projects;
  final List<SimpleProjectInfo> selectedProjects;
  final UserEntity currentUser;

  NoticeListModel({
    required this.notices,
    required this.projects,
    required this.selectedProjects,
    required this.currentUser,
  });

  factory NoticeListModel.initial({required UserEntity currentUser}) {
    return NoticeListModel(
      notices: [],
      projects: [],
      selectedProjects: [],
      currentUser: currentUser,
    );
  }

  NoticeListModel copyWith({
    List<Notice>? notices,
    List<SimpleProjectInfo>? projects,
    List<SimpleProjectInfo>? selectedProjects,
    UserEntity? currentUser,
  }) {
    return NoticeListModel(
      notices: notices ?? this.notices,
      projects: projects ?? this.projects,
      selectedProjects: selectedProjects ?? this.selectedProjects,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
