import 'package:expense_tracker/core/theming/AppAssets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../logic/expense_cubit.dart';

class EmptySection extends StatelessWidget {
  const EmptySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            "No Expenses yet,\nhurry up and add one",
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
                if (context.mounted) {
                  context.read<ExpenseCubit>().loadExpenses(
                    DateTime.now().year,
                    DateTime.now().month,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
