import 'package:flutter/material.dart';
import 'package:todo_app/core/ui/widgets/text_fields/text_field_widget.dart';

class CustomTimePicker extends StatefulWidget {
  final double width;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeChanged;

  const CustomTimePicker({
    super.key,
    this.width = 100,
    this.selectedTime,
    required this.onTimeChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.selectedTime ?? TimeOfDay.now();
  }

  void _showTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime!,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });

      widget.onTimeChanged(_selectedTime!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _showTimePicker(context),
          child: AbsorbPointer(
            child: SizedBox(
              width: widget.width,
              child: TextFieldWidget(
                subIcon: Icons.access_time,
                hintText:
                    _selectedTime == null ? "" : _selectedTime!.format(context), // Hiển thị giờ được chọn
              ),
            ),
          ),
        ),
      ],
    );
  }
}
