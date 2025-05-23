import 'package:expense_tracker/domain/logic/expense_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../domain/logic/expense_cubit.dart';

class AddExpenseButton extends StatelessWidget {
  const AddExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: () async {
          final result = await Navigator.pushNamed(
            context,
            Routes.addExpenseScreen,
          );
          if (result == true) {
            if(context.mounted) {
              context.read<ExpenseCubit>().loadExpenses();
              context.read<ExpenseSummaryCubit>().fetchExpensePercentages();
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Add Expense",
              style: TextStyles.title.copyWith(color: AppColors.primaryColor),
            ),
            Icon(Icons.add, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
