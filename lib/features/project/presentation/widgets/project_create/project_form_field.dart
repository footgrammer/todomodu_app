import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_date_range_field.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_description_field.dart';
import 'package:todomodu_app/features/project/presentation/widgets/project_create/project_title_field.dart';

class ProjectFormField extends StatelessWidget {
  const ProjectFormField({
    super.key,
    required this.titleController,
    required this.titleFocusNode,
    required this.descriptionController,
    required this.descriptionFocusNode,
    required this.startDateProvider,
    required this.endDateProvider,
  });

  final TextEditingController titleController;
  final FocusNode titleFocusNode;
  final TextEditingController descriptionController;
  final FocusNode descriptionFocusNode;
  final AutoDisposeStateProvider<DateTime?> startDateProvider;
  final AutoDisposeStateProvider<DateTime?> endDateProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectTitleField(
          titleController: titleController,
          titleFocusNode: titleFocusNode,
        ),
        SizedBox(height: 32),
        ProjectDateRangeField(
          startDateProvider: startDateProvider,
          endDateProvider: endDateProvider,
        ),
        SizedBox(height: 32),
        ProjectDescriptionField(
          descriptionController: descriptionController,
          descriptionFocusNode: descriptionFocusNode,
        ),
      ],
    );
  }
}
