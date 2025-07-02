import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectProgressState {
  final double percent;
  final int stepIndex;
  final String message;
  final bool isCompleted;

  ProjectProgressState({
    required this.percent,
    required this.stepIndex,
    required this.message,
    this.isCompleted = false,
  });

  factory ProjectProgressState.initial() => ProjectProgressState(
    percent: 0.0,
    stepIndex: -1,
    message: '',
    isCompleted: false,
  );

  ProjectProgressState copyWith({
    double? percent,
    int? stepIndex,
    String? message,
    bool? isCompleted,
  }) {
    return ProjectProgressState(
      percent: percent ?? this.percent,
      stepIndex: stepIndex ?? this.stepIndex,
      message: message ?? this.message,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

final projectProgressProvider =
    NotifierProvider<ProgressController, ProjectProgressState>(
      () => ProgressController(),
    );

class ProgressController extends Notifier<ProjectProgressState> {
  final List<_StepInfo> _steps = [
    _StepInfo(0.25, '당신의 계획을 이해하고 있어요...'),
    _StepInfo(0.5, '할 일을 하나씩 정리 중이에요...'),
    _StepInfo(0.9, '할 일 목록 구성 완료!'),
  ];
  Timer? _timer;
  bool _isDisposed = false;

  @override
  ProjectProgressState build() {
    ref.onDispose(() {
      _timer?.cancel();
      _isDisposed = true;
    });

    return ProjectProgressState.initial();
  }

  void startProgress() async {
    final steps = _steps;

    for (int i = 0; i < _steps.length; i++) {
      if (state.isCompleted == true) {
        _timer?.cancel();
        return;
      }
      await Future.delayed(Duration(seconds: 2));
      if (_isDisposed) return;
      state = ProjectProgressState(
        percent: steps[i].percent,
        stepIndex: i,
        message: steps[i].message,
      );
    }
  }

  Future<void> completeRequest() async {
    state = ProjectProgressState(
      percent: 1.0,
      stepIndex: _steps.length,
      message: '완료되었습니다.',
      isCompleted: true,
    );

    await Future.delayed(Duration(seconds: 1));
  }

  void reset() {
    _isDisposed = false;
    state = ProjectProgressState.initial();
  }

  void resetAndStart() {
    reset();
    startProgress();
  }
}

class _StepInfo {
  final double percent;
  final String message;
  _StepInfo(this.percent, this.message);
}
