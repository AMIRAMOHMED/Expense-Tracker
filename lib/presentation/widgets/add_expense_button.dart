
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/routing/routes.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import 'custom_button.dart';

class AddExpenseButton extends StatelessWidget {
  const AddExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   Positioned(
      // Modified this section
      top: 20.h,
      left: 230.w,
      right: 20.w,
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, Routes.addExpenseScreen);
        },
        child: Row(
          children: [
            Text("Add Expense", style: TextStyles.small.copyWith(color: AppColors.primaryColor),),
            Icon(Icons.add, color: AppColors.primaryColor,)
          ],
        ),
      ),
    );
  }
}
