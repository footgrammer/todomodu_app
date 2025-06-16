import 'package:todomodu_app/features/notice/domain/entities/notice.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';

class NoticeListModel {
  final List<Project> projects;
  final List<Notice> notices;
  final bool isLoading;
  final String? error;

  NoticeListModel({
    required this.projects,
    required this.notices,
    required this.isLoading,
    this.error,
  });

  NoticeListModel copyWith({
    List<Project>? projects,
    List<Notice>? notices,
    bool? isLoading,
    String? error,
  }) {
    return NoticeListModel(
      projects: projects ?? this.projects,
      notices: notices ?? this.notices,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory NoticeListModel.initial() {
    return NoticeListModel(
      projects: [],
      notices: [],
      isLoading: false,
      error: null,
    );
  }
}
