import 'package:get_it/get_it.dart';
import 'package:todo_app/features/home/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/home/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/home/domain/usecase/fetch_todos_usecase.dart';
import 'package:todo_app/features/home/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<TodoRepository>(TodoRepositoryImpl());
  sl.registerFactory<FetchTodosUsecase>(
      () => FetchTodosUsecase(sl<TodoRepository>()));
  sl.registerFactory<TodoBloc>(() => TodoBloc(sl<FetchTodosUsecase>()));
}
