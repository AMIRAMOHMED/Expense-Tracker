import 'package:expense_tracker/core/theming/colors.dart';
import 'package:expense_tracker/domain/logic/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/styles.dart';
import '../../data/models/category_model.dart';
import '../../data/models/expense_model.dart';
import '../../domain/logic/expense_summary_cubit.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    final expensePercentages =
        context.read<ExpenseSummaryCubit>().state.expensePercentages;

    return Dismissible(
      key: Key(expense.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
         context.read<ExpenseCubit>().deleteExpense(expense.id!);
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Expense'),
            content: const Text('Are you sure you want to delete this expense?'),
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
      },
      background: Container(
        color: AppColors.redEB,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        child:  Icon(Icons.delete, color: AppColors.whiteFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(_getCategoryForExpense().icon),
                SizedBox(width: 10.w),
                Text(expense.name, style: TextStyles.regular),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${expense.amount} EGP", style: TextStyles.regular),
                    Text(
                      "${(expensePercentages?[expense.id] ?? 0).toStringAsFixed(2)}% of total",
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                IconButton(
                  icon:  Icon(Icons.edit, size: 20 ,color: AppColors.primaryColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditExpenseScreen(expense: expense),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  CategoryModel _getCategoryForExpense() {
    return CategoryModel.categories.firstWhere(
          (category) => category.id == expense.categoryId,
    );
  }
}

// Placeholder for edit screen - replace with your implementation
class EditExpenseScreen extends StatelessWidget {
  final ExpenseModel expense;
  const EditExpenseScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Expense')),
      body: const Center(child: Text('Implement your edit UI here')),
    );
  }
}