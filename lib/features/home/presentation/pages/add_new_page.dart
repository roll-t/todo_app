import 'package:flutter/material.dart';

class AddNewPage extends StatelessWidget {
  const AddNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child:  Text('this is add new page!'),
      ),
    );
  }
}
