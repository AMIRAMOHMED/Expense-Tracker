import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/expense_model.dart';
import '../../../domain/logic/expense_summary_cubit.dart';
import 'dismissible_wrapper.dart';
import 'expense_content.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    final expensePercentages =
        context.read<ExpenseSummaryCubit>().state.expensePercentages;

    return DismissibleWrapper(
      expense: expense,
      child: ExpenseContent(
        expense: expense,
        percentage: (expensePercentages?[expense.id] ?? 0).toDouble(),
      ),
    );
  }
}
