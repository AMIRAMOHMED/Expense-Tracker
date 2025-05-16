import 'package:expense_tracker/core/theming/AppAssets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../domain/logic/expense_cubit.dart';
import '../../../domain/logic/expense_summary_cubit.dart';
import '../../../core/widgets/custom_button.dart';

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
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                Routes.addExpenseScreen,
              );
              if (result == true) {
                context.read<ExpenseCubit>().loadExpenses();
                context.read<ExpenseSummaryCubit>().fetchExpensePercentages();
              }
            },
          ),
        ],
      ),
    );
  }
}
