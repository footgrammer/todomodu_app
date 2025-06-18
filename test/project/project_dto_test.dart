import 'dart:convert';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:todomodu_app/features/project/data/models/project_dto.dart';

void main() {
  test('ProjectDTO : fromJson test', () {
    const sampleJsonString = """
{
  "id": "project_123",
  "title": "여름 방학 계획 세우기",
  "description": "방학 동안의 목표와 활동을 정리한 프로젝트입니다.",
  "color": 4282462923,
  "startDate": {
    "_seconds": 1720000000,
    "_nanoseconds": 0
  },
  "endDate": {
    "_seconds": 1720864000,
    "_nanoseconds": 0
  },
  "invitationCode": "ABC123",
  "isDone": false
}
""";

    final map = jsonDecode(sampleJsonString);
    final projectDto = ProjectDto.fromJson(map);
    expect(projectDto.color, Color(4282462923));
    expect(projectDto.description, "방학 동안의 목표와 활동을 정리한 프로젝트입니다.");
    expect(
      projectDto.startDate,
      DateTime.fromMillisecondsSinceEpoch(1720000000 * 1000),
    );
  });
}
