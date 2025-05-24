import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../logic/expense_cubit.dart';

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
            if (context.mounted) {
              context.read<ExpenseCubit>().loadExpenses(
                DateTime.now().year,
                DateTime.now().month,
              );
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
