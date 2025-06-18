import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';

class NoticeListModel {
  final List<Project> projects;
  final List<Project> selectedProjects;
  final List<Notice> notices;
  final List<Notice> selectedNotices;
  final bool isLoading;
  final String? error;

  NoticeListModel({
    required this.projects,
    required this.notices,
    List<Project>? selectedProjects,
    List<Notice>? selectedNotices,
    required this.isLoading,
    this.error,
  }) :
    selectedProjects = selectedProjects ?? List<Project>.from(projects),
    selectedNotices = selectedNotices ?? List<Notice>.from(notices);

  NoticeListModel copyWith({
    List<Project>? projects,
    List<Project>? selectedProjects,
    List<Notice>? notices,
    List<Notice>? selectedNotices,
    bool? isLoading,
    String? error,
  }) {
    final newProjects = projects ?? this.projects;
    final newNotices = notices ?? this.notices;
    return NoticeListModel(
      projects: newProjects,
      selectedProjects: selectedProjects ?? this.selectedProjects,
      notices: newNotices,
      selectedNotices: selectedNotices ?? this.selectedNotices,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  factory NoticeListModel.initial() {
    return NoticeListModel(
      projects: [],
      selectedProjects: [],
      notices: [],
      selectedNotices: [],
      isLoading: false,
      error: null,
    );
  }
}
