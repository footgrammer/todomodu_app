import 'package:flutter/material.dart';
import 'package:todomodu_app/shared/themes/app_theme.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  final Map<String, bool> _settings = {
    '새로운 공지': true,
    '팀원 입장/퇴장': true,
    '할 일 추가/수정/삭제': true,
    '할 일 완료': true,
    '할 일 담당자 배정/변경': true,
    '프로젝트 종료일 안내': true,
    '프로젝트 정보 수정': true,
    '프로젝트 완료': true,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => Navigator.pop(context),
                child: const SizedBox(
                  width: 36,
                  height: 36,
                  child: Icon(Icons.arrow_back_ios_new, size: 18),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '알림 설정',
              style: AppTextStyles.header3.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          _buildSection(['새로운 공지', '팀원 입장/퇴장']),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: AppColors.grey200),
              ),
              color: AppColors.grey75,
            ),
          ),
          _buildSection(['할 일 추가/수정/삭제', '할 일 완료', '할 일 담당자 배정/변경']),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: AppColors.grey200),
              ),
              color: AppColors.grey75,
            ),
          ),
          _buildSection(['프로젝트 종료일 안내', '프로젝트 정보 수정', '프로젝트 완료']),
        ],
      ),
    );
  }

  Widget _buildSection(List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children:
              items.map((title) {
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    title,
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.grey800,
                    ),
                  ),
                  value: _settings[title]!,
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.primary500,
                  onChanged: (value) {
                    setState(() {
                      _settings[title] = value;
                    });
                  },
                  visualDensity: const VisualDensity(
                    horizontal: -2.0,
                    vertical: -2.0,
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
