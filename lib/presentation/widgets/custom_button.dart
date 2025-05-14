import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final void Function()? onPressed;
  final String text;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.text = 'text',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        color: color,
        minWidth: 300.w,
        height: 40.h,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20) ),
        onPressed: onPressed,
        child: Text(text, style: TextStyles.regular.copyWith(color: AppColors.whiteFF),),
      ),
    );
  }
}
