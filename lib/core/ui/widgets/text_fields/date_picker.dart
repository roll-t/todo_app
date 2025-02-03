import 'package:flutter/material.dart';
import 'package:todo_app/core/ui/widgets/text_fields/text_field_widget.dart';

class CustomDatePicker extends StatefulWidget {
  final double width;
  final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;

  const CustomDatePicker({
    super.key,
    this.width = 100,
    this.selectedDate,
    required this.onDateChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
    // Khởi tạo controller với giá trị ngày hiện tại
    _controller.text = _selectedDate != null
        ? "${_selectedDate!.toLocal()}"
            .split(' ')[0] // Định dạng ngày theo 'yyyy-MM-dd'
        : '';
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        // Cập nhật lại controller mỗi khi ngày thay đổi
        _controller.text = "${_selectedDate!.toLocal()}"
            .split(' ')[0]; // Định dạng ngày 'yyyy-MM-dd'
      });

      widget.onDateChanged(_selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _showDatePicker(context),
          child: AbsorbPointer(
            child: SizedBox(
              width: widget.width,
              child: TextFieldWidget(
                subIcon: Icons.calendar_month,
                hintText: '', // Để trống hintText
                controller:
                    _controller, // Sử dụng controller để duy trì giá trị trong TextField
              ),
            ),
          ),
        ),
      ],
    );
  }
}
