import 'package:flutter/material.dart';
import 'package:todo_app/core/ui/widgets/text_fields/text_field_widget.dart';

class CustomDatePicker extends StatefulWidget {
  final double width;
  final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;  // Thêm hàm callback để truyền sự kiện ra ngoài

  const CustomDatePicker({
    super.key,
    this.width = 100,
    this.selectedDate,
    required this.onDateChanged,  // Khai báo hàm callback
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedDate with the widget's selectedDate if it's provided
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!, // Use the current date or selected date
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
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
                hintText: _selectedDate == null
                    ? ""
                    : "${_selectedDate!.toLocal()}"
                        .split(' ')[0], // Display date in 'yyyy-MM-dd' format
              ),
            ),
          ),
        ),
      ],
    );
  }
}
