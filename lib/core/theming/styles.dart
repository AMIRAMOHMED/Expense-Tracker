import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class TextStyles {
  TextStyles._();

  static TextStyle tiny = TextStyle(fontSize: 10.sp, color: AppColors.black00);

  static TextStyle small = TextStyle(fontSize: 12.sp, color: AppColors.black00);

  static TextStyle regular = TextStyle(
    fontSize: 14.sp,
    color: AppColors.black00,
  );

  static TextStyle bold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );

  static TextStyle title = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black00,
  );
}
