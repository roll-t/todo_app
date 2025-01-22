import 'package:get_it/get_it.dart'; // Cần import GetIt
import 'package:todo_app/core/service/api/data/source/todo/todo_service.dart';
import 'package:todo_app/core/service/public/data/repositories/category_repository_impl.dart';
import 'package:todo_app/core/service/public/data/source/category_service.dart';
import 'package:todo_app/core/service/public/domain/repositories/category_repository.dart';
import 'package:todo_app/core/service/public/domain/usecase/categories/fetch_category_usecase.dart';
import 'package:todo_app/features/home/add_todo/data/repositories/add_todo_repository_impl.dart';
import 'package:todo_app/features/home/add_todo/domain/repositories/add_todo_repository.dart';
import 'package:todo_app/features/home/add_todo/domain/usecase/save_todo_usecase.dart';
import 'package:todo_app/features/home/add_todo/presentation/bloc/add_todo_bloc.dart';
import 'package:todo_app/features/home/todo_list/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/home/todo_list/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/home/todo_list/domain/usecase/check_complete_todo_usecase.dart';
import 'package:todo_app/features/home/todo_list/domain/usecase/fetch_todos_usecase.dart';
import 'package:todo_app/features/home/todo_list/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<CategoryService>(CategoryService());
  sl.registerSingleton<TodoService>(TodoService());
  sl.registerSingleton<CategoryRepository>(
      CategoryRepositoryImpl(sl<CategoryService>()));
  sl.registerSingleton<TodoRepository>(TodoRepositoryImpl(sl<TodoService>()));
  sl.registerSingleton<AddTodoRepository>(
      AddTodoRepositoryImpl(sl<TodoService>()));
  sl.registerFactory<FetchTodosUsecase>(
      () => FetchTodosUsecase(sl<TodoRepository>()));
  sl.registerFactory<SaveTodoUsecase>(
      () => SaveTodoUsecase(sl<AddTodoRepository>()));

  sl.registerFactory<FetchCategoryUsecase>(
      () => FetchCategoryUsecase(sl<CategoryRepository>()));
  sl.registerFactory<CheckCompleteTodoUsecase>(
      () => CheckCompleteTodoUsecase(sl<TodoRepository>()));

  sl.registerFactory<TodoBloc>(
      () => TodoBloc(sl<FetchTodosUsecase>(), sl<CheckCompleteTodoUsecase>()));

  sl.registerFactory<AddTodoBloc>(
      () => AddTodoBloc(sl<FetchCategoryUsecase>(), sl<SaveTodoUsecase>()));
}
