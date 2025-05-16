import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theming/colors.dart';
import 'custom_text_form_field.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController dateController;
  final String? Function(String?)? validator;

  const DatePickerTextField({
    super.key,
    required this.dateController,
    this.validator,
  });

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      widget.dateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectDate,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: AbsorbPointer(
        child: CustomTextFormField(
          hintText: "mm_dd_yyyy",
          textFieldController: widget.dateController,
          validator: widget.validator,
          readOnly: true,
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_month, color: AppColors.black00),
            onPressed: _selectDate,
          ),
        ),
      ),
    );
  }
}
