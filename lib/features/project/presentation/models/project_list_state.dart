// 상태 클래스
import 'package:flutter/foundation.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';

class ProjectListState {
  List<Project>? projects;
  bool isLoading;
  String errorMessage;
  String fetchType; // 검색 종류(초대코드 혹은 자기가 속한 프로젝트 전체)

  ProjectListState({
    required this.projects,
    this.isLoading = false,
    this.errorMessage = '',
    this.fetchType = 'myProjects',
  });

  ProjectListState copyWith({
    List<Project>? projects,
    bool? isLoading,
    String? errorMessage,
    String? fetchType,
  }) {
    return ProjectListState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      fetchType: fetchType ?? this.fetchType,
    );
  }
}
