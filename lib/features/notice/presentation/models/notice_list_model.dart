import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/features/project/domain/entities/simple_project_info.dart';

class NoticeListModel {
  final List<SimpleProjectInfo> projects;
  final List<SimpleProjectInfo> selectedProjects;
  final List<Notice> notices;
  final List<Notice> selectedNotices;
  final bool isLoading;
  final String? error;

  NoticeListModel({
    required this.projects,
    required this.notices,
    required this.isLoading,
    List<SimpleProjectInfo>? selectedProjects,
    List<Notice>? selectedNotices,
    this.error,
  }) : selectedProjects =
           selectedProjects ?? List<SimpleProjectInfo>.from(projects),
       selectedNotices = selectedNotices ?? List<Notice>.from(notices);

  /// ✅ 초기 상태 생성자
  factory NoticeListModel.initial() {
    return NoticeListModel(
      projects: [],
      notices: [],
      isLoading: false,
      selectedProjects: [],
      selectedNotices: [],
      error: null,
    );
  }

  NoticeListModel copyWith({
    List<SimpleProjectInfo>? projects,
    List<SimpleProjectInfo>? selectedProjects,
    List<Notice>? notices,
    List<Notice>? selectedNotices,
    bool? isLoading,
    String? error,
  }) {
    return NoticeListModel(
      projects: projects ?? this.projects,
      selectedProjects: selectedProjects ?? this.selectedProjects,
      notices: notices ?? this.notices,
      selectedNotices: selectedNotices ?? this.selectedNotices,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<Notice> getNoticesByProject(String projectId) {
    return notices.where((n) => n.projectId == projectId).toList();
  }
}
