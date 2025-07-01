import 'package:flutter/material.dart';
import 'package:todomodu_app/features/activity_history/domain/entities/activity_history.dart';
import 'package:todomodu_app/features/activity_history/presentation/utils/activity_history_formatter.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/utils/date_utils.dart';

class ActivityHistoryListElement extends StatelessWidget {
  const ActivityHistoryListElement({
    super.key,
    required this.history,
    required this.projectName,
  });

  final ActivityHistory history;
  final String projectName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                projectName,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColors.grey700),
              ),
              Text(
                timeAgo(history.createdAt),
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColors.grey700),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            history.toReadableMessage(projectName: projectName),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: AppColors.grey900),
          ),
        ],
      ),
    );
  }
}
