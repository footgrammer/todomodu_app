import 'package:flutter_riverpod/flutter_riverpod.dart';

final progressProvider = StateProvider.family<double, String>((ref, projectId) => 0.0);
