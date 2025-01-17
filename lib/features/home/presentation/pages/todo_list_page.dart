import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app/core/routes/task_detail_screen.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/ui/icons/leading_icon_app_bar.dart';
import 'package:todo_app/core/ui/widgets/buttons/elevated_button_widget.dart';
import 'package:todo_app/core/ui/widgets/texts/text_widget.dart';
import 'package:todo_app/core/utils/datetime_utils.dart';
import 'package:todo_app/features/home/data/entities/todo_item_model.dart';
import 'package:todo_app/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/features/home/presentation/bloc/todo_event.dart';
import 'package:todo_app/features/home/presentation/bloc/todo_state.dart';
import 'package:todo_app/injections.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      //initial todo list data
      create: (BuildContext context) =>
          sl<TodoBloc>()..add(InitializeTodoEvent()),

      child: Scaffold(
        body: Stack(
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
                        _buildTodoList(),
                        _buildTodoListCompleted(),
                        _buildSpaceWithBottom()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildButtonAddNew(context)
          ],
        ),
      ),
    );
  }

  Positioned _buildButtonAddNew(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 10.w,
      right: 10.w,
      child: ElevatedButtonWidget(
        onPressed: () {
          Navigator.pushNamed(context, TaskDetailScreen.addNew);
        },
      ),
    );
  }

  SizedBox _buildSpaceWithBottom() {
    return const SizedBox(
      height: 100,
    );
  }

  SizedBox _buildTodoListCompleted() {
    return SizedBox(
      width: 90.w,
      child: BlocBuilder<TodoBloc, TodoState>(
          builder: (BuildContext context, state) {
        var doneItems = state.items.where((item) => item.isDone).toList();
        return doneItems.isEmpty
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
                                    last: index == doneItems.length - 1,
                                    todoItemModel: todoData,
                                    onCheck: (value) {
                                      // Cập nhật trạng thái lại nếu cần
                                      context.read<TodoBloc>().add(
                                            ToggleTodoEvent(
                                              index:
                                                  state.items.indexOf(todoData),
                                              isCheck: value,
                                            ),
                                          );
                                    },
                                  );
                                },
                              ),
                            )),
                ],
              );
      }),
    );
  }

  Widget _buildTodoList() {
    return Container(
      constraints: BoxConstraints(minHeight: 30.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 90.w,
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (BuildContext context, state) {
          if (state.items.isEmpty) {
            return _buildShimmer();
          } else {
            var todoItems = state.items.where((item) => !item.isDone).toList();
            return todoItems.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(5)),
                    width: 90.w,
                    child: const Center(
                      child: TextWidget(text: "non-available todo"),
                    ),
                  )
                : Column(
                    children: List.generate(
                      todoItems.length,
                      (index) {
                        TodoItemModel todoData = todoItems[index];
                        return _buildItemTodoList(
                          onTap: () {},
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
        },
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5, // Số lượng item shimmer
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

  Container _buildItemTodoList(
      {bool last = false,
      required Function() onTap,
      Function(bool)? onCheck,
      required TodoItemModel todoItemModel}) {
    return Container(
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
                      color: todoItemModel.category.color.withOpacity(.4),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: IconButton(
                      color: todoItemModel.category.color,
                      onPressed: onTap,
                      icon: Icon(
                        todoItemModel.category.icons,
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
                          text: todoItemModel.title,
                          strikethrough: todoItemModel.isDone,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      if (todoItemModel.time != null)
                        TextWidget(
                          text: todoItemModel.time ?? "",
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
    );
  }
}
