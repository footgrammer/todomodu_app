import 'package:todomodu_app/shared/types/result.dart';

extension ResultWhen<T> on Result<T> {
  R when<R>({
    required R Function(T value) ok,
    required R Function(Exception error) error,
  }) {
    if (this is Ok<T>) {
      return ok((this as Ok<T>).value);
    } else if (this is Error<T>) {
      return error((this as Error<T>).error);
    }
    throw Exception('Unhandled Result state');
  }
}
