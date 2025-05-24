import 'package:flutter/material.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    this.hintText,
    this.onChanged,
    this.suffixIcon,
    required this.textFieldController,
    this.onTap,
    this.errorText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
  });

  String? hintText;
  Function(String)? onChanged;
  final Widget? suffixIcon;
  bool readOnly = false;
  TextInputType keyboardType;
  final TextEditingController textFieldController;
  final Function()? onTap;
  final String? Function(String?)? validator;
  String? errorText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        style: TextStyles.small,
        enabled: true,
        validator:
            widget.validator != null
                ? (value) => widget.validator!(value)
                : null,
        keyboardType: widget.keyboardType,
        controller: widget.textFieldController,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        onTap: widget.onTap,

        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
          fillColor: AppColors.whiteFF,
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          hintStyle: TextStyles.small.copyWith(color: AppColors.greyB2),
          errorText: widget.errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color:
                  widget.errorText == null ? AppColors.greyB2 : AppColors.redEB,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color:
                  widget.errorText == null ? AppColors.greyB2 : AppColors.redEB,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color:
                  widget.errorText == null ? AppColors.greyB2 : AppColors.redEB,
            ),
          ),
        ),
      ),
    );
  }
}
