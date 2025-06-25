// 상태 클래스
import 'package:flutter/foundation.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';

class ProjectListState {
  List<Project>? projects;
  bool isLoading;
  String errorMessage;

  ProjectListState({
    required this.projects,
    this.isLoading = false,
    this.errorMessage = '',
  });

  ProjectListState copyWith({
    List<Project>? projects,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProjectListState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
