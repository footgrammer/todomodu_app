import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectProgressState {
  final double percent;
  final int stepIndex;
  final String message;

  ProjectProgressState({
    required this.percent,
    required this.stepIndex,
    required this.message,
  });

  factory ProjectProgressState.initial() =>
      ProjectProgressState(percent: 0.0, stepIndex: -1, message: '');
}

final projectProgressProvider =
    NotifierProvider<ProgressController, ProjectProgressState>(
      () => ProgressController(),
    );

class ProgressController extends Notifier<ProjectProgressState> {
  late final List<_StepInfo> _steps;
  Timer? _timer;
  bool _isDisposed = false;

  @override
  ProjectProgressState build() {
    _steps = [
      _StepInfo(0.25, '당신의 계획을 이해하고 있어요...'),
      _StepInfo(0.5, '할 일을 하나씩 정리 중이에요...'),
      _StepInfo(0.9, '할 일 목록 구성 완료!'),
    ];
    _startProgress();

    ref.onDispose(() {
      _timer?.cancel();
      _isDisposed = true;
    });

    return ProjectProgressState.initial();
  }

  void _startProgress() {
    final durations = [
      Duration(seconds: 2),
      Duration(seconds: 3),
      Duration(seconds: 4),
    ];

    for (int i = 0; i < _steps.length; i++) {
      Future.delayed(durations[i], () {
        if (_isDisposed) return;
        state = ProjectProgressState(
          percent: _steps[i].percent,
          stepIndex: i,
          message: _steps[i].message,
        );
      });
    }
  }

  Future<void> completeRequest() async {
    state = ProjectProgressState(
      percent: 1.0,
      stepIndex: _steps.length,
      message: '완료되었습니다.',
    );

    await Future.delayed(Duration(seconds: 1));
  }

  void reset() {
    state = ProjectProgressState.initial();
  }
}

class _StepInfo {
  final double percent;
  final String message;
  _StepInfo(this.percent, this.message);
}
