import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final _logger = Logger();

void logIfDebug(dynamic message) {
  if (!kReleaseMode) {
    _logger.i(message);
  }
}
