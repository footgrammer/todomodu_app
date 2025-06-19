import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/models/project_list_state.dart';
import 'package:todomodu_app/features/project/presentation/providers/project_providers.dart';
import 'package:todomodu_app/features/user/presentation/providers/user_providers.dart';
import 'package:todomodu_app/shared/types/result.dart';

class ProjectListViewModel extends Notifier<ProjectListState> {
  @override
  ProjectListState build() {
    return ProjectListState(projects: []);
  }

  Future<void> fetchProjectsByUser() async {
    final getCurrentUserUsecase = ref.read(getCurrentUserUsecaseProvider);
    // Stream에서 첫 번째 UserEntity 값을 기다림
    final user = await getCurrentUserUsecase.execute().first;
    if (user == null) {
      // 예외 처리: 로그인되지 않았거나 사용자 정보가 없음
      state = state.copyWith(projects: []);
      return;
    }
    final fetchProjectsByUserUsecase = ref.read(
      fetchProjectsByUserUsecaseProvider,
    );
    final result = await fetchProjectsByUserUsecase.execute(user!);
    state = switch (result) {
      Ok(value: final projects) => state.copyWith(projects: projects),
      Error(:final error) => state.copyWith(projects: []),
    };
  }
}
