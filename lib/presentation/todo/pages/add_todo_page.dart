import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app/core/routes/task_detail_screen.dart';
import 'package:todo_app/core/service/data/categories/entities/category_model.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/ui/icons/leading_icon_app_bar.dart';
import 'package:todo_app/core/ui/widgets/buttons/elevated_button_widget.dart';
import 'package:todo_app/core/ui/widgets/text_fields/date_picker.dart';
import 'package:todo_app/core/ui/widgets/text_fields/text_area_widget.dart';
import 'package:todo_app/core/ui/widgets/text_fields/text_field_widget.dart';
import 'package:todo_app/core/ui/widgets/text_fields/time_picker.dart';
import 'package:todo_app/core/ui/widgets/texts/text_widget.dart';
import 'package:todo_app/injections.dart';
import 'package:todo_app/presentation/todo/bloc/add_todo/add_todo_bloc.dart';
import 'package:todo_app/presentation/todo/bloc/add_todo/add_todo_event.dart';
import 'package:todo_app/presentation/todo/bloc/add_todo/add_todo_state.dart';
import 'package:todo_app/presentation/todo/widgets/category_item_widget.dart';

class AddTodoArg {
  final bool isReload;
  AddTodoArg(this.isReload);
}

class AddTodoPage extends StatelessWidget {
  static String routeName = TaskDetailScreen.addNew;
  final AddTodoArg addTodoArg;
  const AddTodoPage({super.key, required this.addTodoArg});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddTodoBloc>(
      create: (BuildContext context) =>
          sl<AddTodoBloc>()..add(InitializeAddTodoEvent()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: 100.h),
            child: Stack(
              children: [
                _buildAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      _buildSpaceWithTop(),
                      _buildInputTitle(),
                      _buildSpacing(),
                      _buildCategorySelection(),
                      _buildSpacing(),
                      _buildTimePicker(),
                      _buildSpacing(),
                      _buildNote(),
                      _buildSpacing(),
                    ],
                  ),
                ),
                _buildButtonSave(),
                _buildWaitingProcess(),
                _buildListenerCallBack()
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocListener<AddTodoBloc, AddTodoState> _buildListenerCallBack() {
    return BlocListener<AddTodoBloc, AddTodoState>(
      listener: (BuildContext context, state) {
        if (state.isWaiting != null && state.isWaiting == true) {
          Navigator.pop(context, true);
          Fluttertoast.showToast(msg: "Todo added successfully!");
        }
        if (state.isWaiting != null && state.isWaiting == false) {
          Navigator.pop(context, false);
          Fluttertoast.showToast(msg: "Failed add todo!");
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget _buildWaitingProcess() {
    return BlocBuilder<AddTodoBloc, AddTodoState>(
        builder: (BuildContext context, state) {
      return (state.isWaiting != null && (state.isWaiting == true))
          ? Positioned(
              child: Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.blackColor.withOpacity(.4),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ))
          : const SizedBox.shrink();
    });
  }
}

Widget _buildButtonSave() {
  return Positioned(
      left: 10.w,
      right: 10.w,
      bottom: 5.w,
      child: BlocBuilder<AddTodoBloc, AddTodoState>(builder: (
        BuildContext context,
        state,
      ) {
        return ElevatedButtonWidget(
          onPressed: () async {
            context.read<AddTodoBloc>().add(HandleSaveTodoEvent());
          },
          backgroundColor: AppColors.primaryColor,
          text: 'Save',
        );
      }));
}

Widget _buildNote() {
  Timer? debounce;
  final TextEditingController notesController = TextEditingController();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const TextWidget(
        text: "Notes",
        fontWeight: FontWeight.w500,
      ),
      const SizedBox(
        height: 5,
      ),
      BlocBuilder<AddTodoBloc, AddTodoState>(
          builder: (BuildContext context, state) {
        return TextAreaWidget(
          hintText: "Notes",
          maxLines: 10,
          onChanged: (value) {
            if (debounce?.isActive ?? false) debounce?.cancel();
            debounce = Timer(const Duration(milliseconds: 200), () {
              context
                  .read<AddTodoBloc>()
                  .add(UpdateNotesEvent(notes: notesController.text));
            });
          },
          controller: notesController,
          minLines: 5,
          borderRadius: 5,
          borderColor: Colors.black,
          padding: const EdgeInsets.all(16),
        );
      }),
    ],
  );
}

Widget _buildTimePicker() {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            text: "Date",
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<AddTodoBloc, AddTodoState>(
              builder: (BuildContext context, state) {
            return CustomDatePicker(
              onDateChanged: (DateTime newDate) {
                context
                    .read<AddTodoBloc>()
                    .add(UpdateDateEvent(newDate: newDate));
              },
              width: 43.w,
              selectedDate: state.selectedDate,
            );
          })
        ],
      ),
      const Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            text: "Time",
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<AddTodoBloc, AddTodoState>(
              builder: (BuildContext context, state) {
            return CustomTimePicker(
              onTimeChanged: (TimeOfDay newTime) {
                context
                    .read<AddTodoBloc>()
                    .add(UpdateTimeEvent(newTime: newTime));
              },
              width: 43.w,
              selectedTime: state.selectedTime,
            );
          })
        ],
      ),
    ],
  );
}

Widget _buildSpacing() => SizedBox(height: 5.w);

Widget _buildCategorySelection() {
  return BlocBuilder<AddTodoBloc, AddTodoState>(
      builder: (BuildContext context, state) {
    final List<CategoryModel> categories = state.categories;
    return Row(
      crossAxisAlignment: categories.length > 3
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        const TextWidget(text: "Category: ", fontWeight: FontWeight.w500),
        categories.isEmpty
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  width: 50.w,
                  height: 35,
                ))
            : SizedBox(
                width: 70.w,
                child: Wrap(
                  runSpacing: 10,
                  children: List.generate(categories.length, (index) {
                    bool isCategorySelected =
                        context.watch<AddTodoBloc>().state.selectedCategory ==
                            categories[index];
                    CategoryModel category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<AddTodoBloc>()
                            .add(SelectCategoryEvent(categories[index]));
                      },
                      child: CategoryItemWidget(
                        isCategorySelected: isCategorySelected,
                        category: category,
                      ),
                    );
                  }),
                ),
              )
      ],
    );
  });
}

Widget _buildInputTitle() {
  Timer? debounce;
  final TextEditingController titleController = TextEditingController();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const TextWidget(
        text: "Task Title",
        fontWeight: FontWeight.w500,
      ),
      const SizedBox(
        height: 5,
      ),
      BlocBuilder<AddTodoBloc, AddTodoState>(
          builder: (BuildContext context, state) {
        return TextFieldWidget(
          controller: titleController,
          onChanged: (value) {
            if (debounce?.isActive ?? false) debounce?.cancel();
            debounce = Timer(const Duration(milliseconds: 200), () {
              context
                  .read<AddTodoBloc>()
                  .add(UpdateTitleTaskEvent(titleTask: titleController.text));
            });
          },
          hintText: "Task title",
        );
      })
    ],
  );
}

Widget _buildSpaceWithTop() {
  return SizedBox(
    height: 30.w,
  );
}

Widget _buildAppBar() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    decoration: const BoxDecoration(color: AppColors.primaryColor),
    height: 25.w,
    child: Stack(
      children: [
        const Align(
            alignment: Alignment.centerLeft, child: LeadingIconAppBar()),
        Center(
            child: TextWidget(
          text: "Add New Task",
          size: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ))
      ],
    ),
  );
}
