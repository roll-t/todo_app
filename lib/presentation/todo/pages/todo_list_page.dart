import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app/core/extensions/hexColor.dart';
import 'package:todo_app/core/routes/task_detail_screen.dart';
import 'package:todo_app/core/service/data/todo/entities/todo_item_model.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/ui/icons/leading_icon_app_bar.dart';
import 'package:todo_app/core/ui/widgets/buttons/elevated_button_widget.dart';
import 'package:todo_app/core/ui/widgets/texts/text_widget.dart';
import 'package:todo_app/core/utils/datetime_utils.dart';
import 'package:todo_app/presentation/todo/bloc/todo_list/todo_bloc.dart';
import 'package:todo_app/presentation/todo/bloc/todo_list/todo_event.dart';
import 'package:todo_app/presentation/todo/bloc/todo_list/todo_state.dart';
import 'package:todo_app/presentation/todo/pages/add_todo_page.dart';

class TodoListPage extends StatelessWidget {
  static String routeName = TaskDetailScreen.todoList;

  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (BuildContext context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<TodoBloc>().add(InitializeTodoEvent());
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      _buildHeader(),
                      SizedBox(
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildSpaceListWithTop(),
                            _buildTodoList(
                              context: context,
                              state: state,
                            ),
                            _buildTodoListCompleted(
                              context: context,
                              state: state,
                            ),
                            _buildSpaceWithBottom()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildButtonAddNew(
                  context: context,
                  state: state,
                ),
                _buildWaitingProcess(
                  context: context,
                  state: state,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWaitingProcess(
      {required BuildContext context, required TodoState state}) {
    return state.isWaiting
        ? Positioned(
            child: Container(
                width: 100.w,
                height: 100.h,
                color: AppColors.blackColor.withOpacity(.4),
                child: const Center(
                  child: CircularProgressIndicator(),
                )))
        : const SizedBox.shrink();
  }

  Widget _buildButtonAddNew(
      {required BuildContext context, required TodoState state}) {
    return Positioned(
      bottom: 10,
      left: 10.w,
      right: 10.w,
      child: ElevatedButtonWidget(
        text: "Add New Task",
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            TaskDetailScreen.addNew,
            arguments: AddTodoArg(false),
          );
          if (result is bool && result == true) {
            // ignore: use_build_context_synchronously
            context.read<TodoBloc>().add(InitializeTodoEvent());
          }
        },
      ),
    );
  }

  SizedBox _buildSpaceWithBottom() {
    return const SizedBox(
      height: 100,
    );
  }

  SizedBox _buildTodoListCompleted({
    required BuildContext context,
    required TodoState state,
  }) {
    var doneItems = state.items.where((item) => item.isDone).toList();
    return SizedBox(
      width: 90.w,
      child: doneItems.isEmpty
          ? const SizedBox.shrink()
          : Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.w),
                      child: TextWidget(
                        text: "Completed",
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 90.w,
                  child: state.items.isEmpty
                      ? _buildShimmer()
                      : Column(
                          children: List.generate(
                            doneItems.length,
                            (index) {
                              TodoItemModel todoData = doneItems[index];
                              return _buildItemTodoList(
                                onTap: () {},
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        title: const Text("Xác nhận"),
                                        content: const Text(
                                            "Bạn có chắc muốn xóa mục này không?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();
                                            },
                                            child: const Text("Hủy"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context.read<TodoBloc>().add(
                                                  DeleteTodoEvent(
                                                      id: todoData.id));
                                              Navigator.of(dialogContext).pop();
                                            },
                                            child: const Text("Xóa",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                last: index == doneItems.length - 1,
                                todoItemModel: todoData,
                                onCheck: (value) {
                                  context.read<TodoBloc>().add(
                                        ToggleTodoEvent(
                                          index: state.items.indexOf(todoData),
                                          isCheck: value,
                                        ),
                                      );
                                },
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildTodoList(
      {required BuildContext context, required TodoState state}) {
    var todoItems = state.items.where((item) => !item.isDone).toList();
    return Container(
      constraints: BoxConstraints(minHeight: 30.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 90.w,
      child: state.loading
          ? _buildShimmer()
          : todoItems.isEmpty
              ? Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 90.w,
                  child: const Center(
                    child: TextWidget(text: "non-available todo"),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: todoItems.length,
                  itemBuilder: (context, index) {
                    TodoItemModel todoData = todoItems[index];

                    return _buildItemTodoList(
                      onTap: () {},
                      onLongPress: () {
                        _showDeleteDialog(context, todoData.id);
                      },
                      todoItemModel: todoData,
                      last: index == todoItems.length - 1,
                      onCheck: (value) {
                        context.read<TodoBloc>().add(
                              ToggleTodoEvent(
                                index: state.items.indexOf(todoData),
                                isCheck: value,
                              ),
                            );
                      },
                    );
                  },
                ),
    );
  }

  void _showDeleteDialog(BuildContext context, String todoId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider<TodoBloc>.value(
          value: context.read<TodoBloc>(),
          child: AlertDialog(
            title: const Text("Xác nhận"),
            content: const Text("Bạn có chắc muốn xóa mục này không?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text("Hủy"),
              ),
              TextButton(
                onPressed: () {
                  context.read<TodoBloc>().add(DeleteTodoEvent(id: todoId));
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("Xóa", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 3.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60.w,
                      height: 2.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 1.w),
                    Container(
                      width: 40.w,
                      height: 1.5.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox _buildSpaceListWithTop() => SizedBox(height: 45.w);

  Positioned _buildHeader() {
    return Positioned(
      child: Container(
        padding: EdgeInsets.only(top: 11.w, left: 5.w, right: 5.w),
        width: 100.w,
        height: 60.w,
        color: AppColors.primaryColor,
        child: Column(
          children: [
            SizedBox(
              width: 100.w,
              height: 15.w,
              child: Stack(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: LeadingIconAppBar()),
                  Align(
                    alignment: Alignment.center,
                    child: TextWidget(
                      color: AppColors.whiteColor,
                      size: 18.sp,
                      fontWeight: FontWeight.w500,
                      text: DatetimeUtils.getCurrentDate(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60.w - (30.w + 22.sp + 18.sp + 15.w)),
            TextWidget(
              color: AppColors.whiteColor,
              size: 22.sp,
              fontWeight: FontWeight.w700,
              text: "My Todo List",
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemTodoList(
      {bool last = false,
      required Function() onTap,
      Function()? onLongPress,
      Function(bool)? onCheck,
      required TodoItemModel todoItemModel}) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.w),
        decoration: BoxDecoration(
          border: !last
              ? const Border(
                  bottom: BorderSide(
                    color: AppColors.greyColorAccent,
                    width: .5,
                  ),
                )
              : const Border(),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: todoItemModel.category.color
                            .toColor()
                            .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: IconButton(
                        color: todoItemModel.category.color.toColor(),
                        onPressed: onTap,
                        icon: Icon(
                          todoItemModel.category.icon,
                          size: 18.sp,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: TextWidget(
                            color: AppColors.blackColor,
                            size: 17.sp,
                            maxLine: 2,
                            fontWeight: FontWeight.w500,
                            text: todoItemModel.name,
                            strikethrough: todoItemModel.isDone,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        if (todoItemModel.createTime != null)
                          TextWidget(
                            text: DatetimeUtils.formatTime(
                                DateTime.parse(todoItemModel.createTime ?? "")),
                            strikethrough: todoItemModel.isDone,
                            color: AppColors.blackColor.withOpacity(.7),
                          )
                      ],
                    ),
                  ],
                ),
                if (todoItemModel.isDone)
                  Positioned.fill(
                      child: Container(
                    color: AppColors.whiteColor.withOpacity(.5),
                  )),
              ],
            ),
            const Spacer(),
            Checkbox(
              value: todoItemModel.isDone,
              onChanged: (bool? value) {
                if (onCheck != null && value != null) {
                  onCheck(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
