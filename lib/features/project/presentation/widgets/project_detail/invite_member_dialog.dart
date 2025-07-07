import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todomodu_app/features/project/domain/entities/project.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';
import 'package:todomodu_app/shared/widgets/custom_icon.dart';

class InviteMemberDialog extends StatelessWidget {
  const InviteMemberDialog({super.key, required this.project});

  final Project project;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('팀원 초대', style: AppTextStyles.header4),
            const SizedBox(height: 8),
            Text(
              textAlign: TextAlign.center,
              '초대 코드를 복사하여\n프로젝트에 팀원을 초대해보세요!',
              style: AppTextStyles.body2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${project.title}의 초대코드',
                        style: AppTextStyles.caption1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: project.invitationCode),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('초대코드가 복사되었습니다')),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              project.invitationCode,
                              style: AppTextStyles.body1,
                            ),
                            const SizedBox(width: 4),
                            CustomIcon(name: 'copy', size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary50,
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () {
                  _shareInvitationCode(project.invitationCode);
                },
                icon: CustomIcon(
                  name: 'link',
                  size: 24,
                  color: AppColors.primary600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _shareInvitationCode(String inviteCode) async {
  final result = await SharePlus.instance.share(
    ShareParams(
      text:
          '투두모두 초대코드: https://k-ouz.github.io/todomodu_deep_link/?invitecode=$inviteCode',
      subject: '투두모두 프로젝트 팀원 초대',
      sharePositionOrigin: Rect.fromLTWH(0, 0, 100, 100),
    ),
  );
  log('공유 결과: ${result.status}');
}
