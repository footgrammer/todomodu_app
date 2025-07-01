import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/domain/usecases/fetch_activity_history_usecase.dart';
import 'package:todomodu_app/features/activity_history/presentation/providers/activity_history_providers.dart';
import 'package:todomodu_app/shared/types/result_extension.dart';

class ActivityHistoryListViewModel
    extends AutoDisposeFamilyAsyncNotifier<List<ActivityHistory>, String> {
  late final FetchActivityHistoryUsecase _usecase;

  @override
  Future<List<ActivityHistory>> build(String projectId) async {
    _usecase = ref.read(fetchActivityHistoryUsecaseProvider);
    final result = await _usecase.execute(projectId);

    return result.when(
      ok: (data) => data,
      error: (e) => throw Exception('활동 기록 불러오기 실패: $e'),
    );
  }
}
