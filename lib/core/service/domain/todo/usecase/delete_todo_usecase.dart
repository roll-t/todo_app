import 'package:todo_app/core/service/domain/todo/repositories/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository _repository;
  DeleteTodoUsecase(this._repository);

  Future<bool> call(String todoId) async {
    return await _repository.deleteTodo(todoId);
  }
}
