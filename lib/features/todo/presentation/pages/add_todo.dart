import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/date_picker_box.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_date_section.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_title_input.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  List<TextEditingController> _subTaskControllers = [];

  Future<void> _pickDate(bool isStart) async {
    final DateTime initial = isStart ? _startDate : _endDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_startDate.isAfter(_endDate)) {
            _endDate = _startDate;
          }
        } else {
          if (picked.isBefore(_startDate)) {
            _endDate = _startDate;
          } else {
            _endDate = picked;
          }
        }
      });
    }
  }

//세부 할 일 추가 함수
  void _addSubTask() {
    setState(() {
      _subTaskControllers.add(TextEditingController());
    });
  }

//세부 할 일 삭제 함수
  void _removeSubTask(int index) {
    setState(() {
      _subTaskControllers[index].dispose();
      _subTaskControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 추가하기'),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodoTitleInput(),
              const SizedBox(height: 24),
              TodoDateSection(startDate: _startDate, endDate: _endDate, onStartTap: () => _pickDate(true), onEndTap: () => _pickDate(false)),
              const SizedBox(height: 24),
              const Text(
                '할 일 목록',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: List.generate(_subTaskControllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _subTaskControllers[index],
                            decoration: InputDecoration(
                                hintText: '세부 할일',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[300],
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 14)),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                            onPressed: () => _removeSubTask(index),
                            icon: const Icon(Icons.remove_circle_outline)),
                      ],
                    ),
                  );
                }),
              ),
              Center(
                child: IconButton(
                    onPressed: _addSubTask,
                    icon: const Icon(Icons.add_circle_outline, size: 36)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 70),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),
            onPressed: () {},
            child: const Text('완료'),
          ),
        ),
      ),
    );
  }
}

