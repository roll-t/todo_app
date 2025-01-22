import 'package:todo_app/features/home/todo_list/domain/repositories/todo_repository.dart';

class CheckCompleteTodoUsecase {
  final TodoRepository _repository;

  CheckCompleteTodoUsecase(this._repository);

  Future<void> call(String todoId) async {
    _repository.checkCompleteTodo(todoId);
  }
}
