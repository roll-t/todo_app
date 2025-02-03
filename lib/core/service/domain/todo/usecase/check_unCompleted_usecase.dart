// ignore: file_names
import 'package:todo_app/core/service/domain/todo/repositories/todo_repository.dart';

class CheckUncompletedUsecase {
  final TodoRepository _repository;

  CheckUncompletedUsecase(this._repository);

  Future<void> call(String todoId) async {
    await _repository.checkUnCompleteTodo(todoId);
  }
}
