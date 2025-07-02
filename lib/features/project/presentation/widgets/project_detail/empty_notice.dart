import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class EmptyNotice extends StatelessWidget {
  const EmptyNotice({super.key});
  final String emptyNoticeMentionTitle = '아직 등록된 공지가 없습니다.';
  final String emptyNoticeMentionSub1 = '안내해야 할 사항이 있을 땐';
  final String emptyNoticeMentionSub2 = '공지 작성 기능을 이용해보세요!';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_notice.png', scale: 2),
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
