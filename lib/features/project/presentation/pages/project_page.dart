import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final projectCodeControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

class ProjectPage extends ConsumerWidget {
  const ProjectPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codeController = ref.watch(projectCodeControllerProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // ✅ 현재 포커스 해제
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 24),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: codeController,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: '프로젝트 코드를 입력하세요',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(child: ListView(children: [Text('haha')])),
            ],
          ),
        ),
      ),
    );
  }
}
