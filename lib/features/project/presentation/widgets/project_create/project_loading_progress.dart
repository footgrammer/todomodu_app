import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_loading_view_model.dart';

class ProjectLoadingProgress extends ConsumerWidget {
  const ProjectLoadingProgress({super.key, required this.progress});

  final ProjectProgressState progress;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: progress.percent,
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation(Color(0xFF5752EA)),
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          Text(
            '${(progress.percent * 100).round()}%',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
