import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          '알림 설정',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildSection(['새로운 공지', '팀원 입장/퇴장']),
          const SizedBox(height: 8),
          _buildSection(['할 일 추가/수정/삭제', '할 일 완료', '할 일 담당자 배정/변경']),
          const SizedBox(height: 8),
          _buildSection(['프로젝트 종료일 안내', '프로젝트 정보 수정', '프로젝트 완료']),
        ],
      ),
    );
  }

  Widget _buildSection(List<String> items) {
    return Container(
      color: Colors.white,
      child: Column(
        children:
            items.map((title) {
              return SwitchListTile(
                title: Text(title),
                value: _settings[title]!,

                activeColor: Colors.white,
                activeTrackColor: Color(0XFF5752EA),
                onChanged: (value) {
                  setState(() {
                    _settings[title] = value;
                  });
                },
              );
            }).toList(),
      ),
    );
  }
}
