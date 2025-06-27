import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todomodu_app/features/ai/data/datasources/openai_data_source.dart';
import 'package:todomodu_app/features/ai/data/models/openai_response_dto.dart';
import 'package:todomodu_app/features/ai/domain/models/openai_params.dart';

class OpenaiDataSourceImpl implements OpenaiDataSource {
  OpenaiDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;
  final String _apiKey = dotenv.env['OPENAI_API_KEY']!;
  @override
  Future<OpenaiResponseDto?> fetchOpenaiResponse(
    OpenaiParams openaiParams,
  ) async {
    try {
      final configDoc =
          await FirebaseFirestore.instance
              .collection('openai_config')
              .doc('default')
              .get();

      final config = configDoc.data();
      if (config == null) throw Exception('OpenAI config not found');

      final model = config['model'] ?? 'gpt-4';
      final maxTokens = config['maxTokens'] ?? 3000;
      final rawPrompt = config['systemPrompt'];
      final String systemPrompt;

      if (rawPrompt != null &&
          rawPrompt is String &&
          rawPrompt.trim().isNotEmpty) {
        systemPrompt = rawPrompt.trim();
      } else {
        systemPrompt = await rootBundle.loadString('assets/prompts/prompt.txt');
      }
      log('model: $model');
      log('maxTokens: $maxTokens');
      log('systemPrompt: $systemPrompt');

      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': model,
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {
              'role': 'user',
              'content':
                  'project_title: ${openaiParams.projectTitle}, project_start_date: ${openaiParams.projectStartDate}, project_end_date: ${openaiParams.projectEndDate}, prompt: ${openaiParams.prompt}',
            },
          ],
          'max_tokens': maxTokens,
        },
      );
      log('${response.statusCode}');

      if (response.statusCode == 200) {
        final result = response.data;
        return OpenaiResponseDto.fromJson(result);
      }
    } catch (e, stack) {
      log('$e, $stack');
    }
    return null;
  }
}
