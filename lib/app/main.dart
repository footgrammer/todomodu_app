import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todomodu_app/app/todomodu_app.dart';

void main() {
  runApp(ProviderScope(child: const TodomoduApp()));
}
