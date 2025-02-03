import 'package:get_it/get_it.dart'; // Cần import GetIt
import 'package:todo_app/core/service/data/categories/repositories/category_repository_impl.dart';
import 'package:todo_app/core/service/data/todo/repositories/add_todo_repository_impl.dart';
import 'package:todo_app/core/service/data/todo/repositories/todo_repository_impl.dart';
import 'package:todo_app/core/service/domain/cateogies/repositories/category_repository.dart';
import 'package:todo_app/core/service/domain/cateogies/usecase/fetch_category_usecase.dart';
import 'package:todo_app/core/service/domain/todo/repositories/add_todo_repository.dart';
import 'package:todo_app/core/service/domain/todo/repositories/todo_repository.dart';
import 'package:todo_app/core/service/domain/todo/usecase/check_complete_todo_usecase.dart';
import 'package:todo_app/core/service/domain/todo/usecase/check_unCompleted_usecase.dart';
import 'package:todo_app/core/service/domain/todo/usecase/delete_todo_usecase.dart';
import 'package:todo_app/core/service/domain/todo/usecase/fetch_category_todo_usecase.dart';
import 'package:todo_app/core/service/domain/todo/usecase/fetch_todos_usecase.dart';
import 'package:todo_app/core/service/domain/todo/usecase/save_todo_usecase.dart';
import 'package:todo_app/core/service/sources/category_service.dart';
import 'package:todo_app/core/service/sources/todo_service.dart';
import 'package:todo_app/presentation/todo/bloc/add_todo/add_todo_bloc.dart';
import 'package:todo_app/presentation/todo/bloc/todo_list/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //
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

  sl.registerFactory<FetchCategoryTodoUsecase>(
      () => FetchCategoryTodoUsecase(sl<CategoryRepository>()));

  sl.registerFactory<DeleteTodoUsecase>(
      () => DeleteTodoUsecase(sl<TodoRepository>()));

  sl.registerFactory<CheckUncompletedUsecase>(
      () => CheckUncompletedUsecase(sl<TodoRepository>()));

  sl.registerFactory<TodoBloc>(() => TodoBloc(
      sl<FetchTodosUsecase>(),
      sl<CheckCompleteTodoUsecase>(),
      sl<CheckUncompletedUsecase>(),
      sl<DeleteTodoUsecase>()));

  sl.registerFactory<AddTodoBloc>(
      () => AddTodoBloc(sl<FetchCategoryTodoUsecase>(), sl<SaveTodoUsecase>()));
}
