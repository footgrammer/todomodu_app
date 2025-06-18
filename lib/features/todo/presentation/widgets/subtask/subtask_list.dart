import 'package:flutter/material.dart';

class SubtaskList extends StatefulWidget {
  final List<TextEditingController> controllers;
  final void Function(int) onRemove;

  const SubtaskList({
    super.key,
    required this.controllers,
    required this.onRemove,
  });

  @override
  State<SubtaskList> createState() => _SubtaskListState();
}

class _SubtaskListState extends State<SubtaskList> {
  @override
  void initState() {
    super.initState();
    for (var c in widget.controllers) {
      c.addListener(_onChange);
    }
  }

  @override
  void didUpdateWidget(SubtaskList oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (var c in widget.controllers) {
      if (!oldWidget.controllers.contains(c)) {
        c.addListener(_onChange);
      }
    }
  }

  @override
  void dispose() {
    for (var c in widget.controllers) {
      c.removeListener(_onChange);
    }
    super.dispose();
  }

  void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.controllers.length, (i) {
        final controller = widget.controllers[i];
        final len = controller.text.length;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 60, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: controller,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          hintText: '세부 할 일',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          counterText: '',
                        ),
                        onChanged: (_) {}, // 이미 컨트롤러 리스너 이용
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 8,
                      child: Text('$len/50', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  widget.onRemove(i);
                  setState(() {});
                },
                icon: const Icon(Icons.remove_circle_outline),
              ),
            ],
          ),
        );
      }),
    );
  }
}
