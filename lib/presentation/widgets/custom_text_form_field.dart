import 'package:flutter/material.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';

class CustomTextFormField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        style: TextStyles.small,
        enabled: true,
        validator: validator != null ? (value) => validator!(value) : null,
        keyboardType: keyboardType,
        controller: textFieldController,
        onChanged: onChanged,
        readOnly: readOnly,
        onTap: onTap,

        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
          fillColor: AppColors.whiteFF,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyles.small.copyWith(color: AppColors.greyB2),
          errorText: errorText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: errorText == null ? AppColors.greyB2 : AppColors.redEB,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: errorText == null ? AppColors.greyB2 : AppColors.redEB,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: errorText == null ? AppColors. greyB2 : AppColors.redEB,
            ),
          ),
        ),
      ),
    );
  }
}
