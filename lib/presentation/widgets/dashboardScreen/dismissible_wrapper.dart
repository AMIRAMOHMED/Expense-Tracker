import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/colors.dart';
import '../../../data/models/expense_model.dart';
import '../../../domain/logic/expense_cubit.dart';
import '../../../domain/logic/expense_summary_cubit.dart';

class DismissibleWrapper extends StatelessWidget {
  final ExpenseModel expense;
  final Widget child;

  const DismissibleWrapper({required this.expense, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(expense.id.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => {
        context.read<ExpenseCubit>().deleteExpense(expense.id!),
        context.read<ExpenseSummaryCubit>().fetchExpensePercentages(),
  },
    confirmDismiss: (direction) => _confirmDismiss(context),
    background: Container(
    color: AppColors.redEB,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 20.w),
    child: const Icon(Icons.delete, color: AppColors.whiteFF),
    ),
    child: child
    ,
    );
  }

  Future<bool?> _confirmDismiss(BuildContext context) async {
    return await showDialog(
      context: context,
      builder:
          (context) =>
          AlertDialog(
            title: const Text('Delete Expense'),
            content: const Text(
              'Are you sure you want to delete this expense?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }


}