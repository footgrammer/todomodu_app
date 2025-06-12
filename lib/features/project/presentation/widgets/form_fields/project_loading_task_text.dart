import 'package:flutter/material.dart';
import 'package:todomodu_app/features/project/presentation/viewmodels/project_loading_view_model.dart';

class ProjectLoadingTaskText extends StatelessWidget {
  const ProjectLoadingTaskText({
    super.key,
    required this.stepMessages,
    required this.progress,
  });

  final List<String> stepMessages;
  final ProjectProgressState progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(stepMessages.length, (i) {
        final active = i <= progress.stepIndex;
        final icon =
            active
                ? Icon(Icons.check_circle, color: Color(0xFF5752EA))
                : Icon(Icons.radio_button_unchecked, color: Colors.grey);
        return Container(
          height: 64,
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              icon,
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  stepMessages[i],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                    color: active ? Color(0xFF403F4B) : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
