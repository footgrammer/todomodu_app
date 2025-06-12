import 'package:flutter/material.dart';
import 'package:todomodu_app/features/todo/application/usecases/create_todo_usecase.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/date_picker_box.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/submit_button.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_date_section.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/sub_task/sub_task_list.dart';
import 'package:todomodu_app/features/todo/presentation/widgets/todo_title_input.dart';

class AddTodoPage extends StatefulWidget {
  final CreateTodoUseCase createTodoUseCase;

  const AddTodoPage({super.key, required this.createTodoUseCase});

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
              TodoSubTaskList(controllers: _subTaskControllers, onRemove: _removeSubTask,),
              Center(
                child: IconButton(
                    onPressed: _addSubTask,
                    icon: const Icon(Icons.add_circle_outline, size: 36)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SubmitButton(
        label: '완료',
        onPressed: () {},),
    );
  }
}


