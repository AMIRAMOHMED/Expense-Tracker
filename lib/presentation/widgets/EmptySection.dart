import 'package:expense_tracker/core/theming/AppAssets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/routing/routes.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import 'custom_button.dart';

class EmptySection extends StatelessWidget {
  const EmptySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Expenses yet , hurry up and add one",
            style: TextStyles.title.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 10),
          SvgPicture.asset(AppAssets.wallet, height: 200.h),
          CustomButton(
            text: 'Add Expense',
            color: AppColors.primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, Routes.addExpenseScreen);
            },
          ),
        ],
      ),
    );
  }
}
