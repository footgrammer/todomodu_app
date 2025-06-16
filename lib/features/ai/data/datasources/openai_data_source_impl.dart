import 'dart:developer';

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
      final systemPrompt = await rootBundle.loadString(
        'assets/prompts/prompt.txt',
      );

      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'gpt-4.1',
          'messages': [
            {'role': 'system', 'content': systemPrompt},
            {
              'role': 'user',
              'content':
                  'project_title: ${openaiParams.projectTitle}, project_start_date: ${openaiParams.projectStartDate}, project_end_date: ${openaiParams.projectEndDate}, prompt: ${openaiParams.prompt}',
            },
          ],
          'max_tokens': 1000,
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
