import 'package:flutter/material.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_list/notice_list_widget.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/notice_searchbar.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/project_chip.dart';
import 'package:todomodu_app/features/notice/presentation/widgets/project_chip_list.dart';

class NoticeListPage extends StatefulWidget {
  const NoticeListPage({super.key});

  @override
  State<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage> {
  final searchbarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('공지')),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                NoticeSearchbar(),
                SizedBox(height: 20,),
                ProjectChipList(),
                SizedBox(height: 20,),
                Expanded(child: NoticeListWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
