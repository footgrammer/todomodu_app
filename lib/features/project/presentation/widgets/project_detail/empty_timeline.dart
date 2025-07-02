import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/constants/app_colors.dart';

class EmptyTimeline extends StatelessWidget {
  const EmptyTimeline({super.key});
  final String emptyNoticeMentionTitle = '아직 타임라인이 기록되지 않았습니다.';
  final String emptyNoticeMentionSub1 = '다른 팀원이 무슨 일을 하고 있는지';
  final String emptyNoticeMentionSub2 = '알고 싶을 땐 타임라인을 이용해 보세요!';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_timeline.png'),
          SizedBox(height: 12),
          Text(
            emptyNoticeMentionTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 4),
          Text(
            emptyNoticeMentionSub1,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.grey600),
          ),
          Text(
            emptyNoticeMentionSub2,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.grey600),
          ),
        ],
      ),
    );
  }
}
