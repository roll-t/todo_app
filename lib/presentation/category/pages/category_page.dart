import 'package:flutter/material.dart';
import 'package:todo_app/core/ui/widgets/texts/text_widget.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextWidget(text: "Category page"),
      ),
    );
  }
}
