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
  @override
  Widget build(BuildContext context) {
    final expensePercentages =
        context.read<ExpenseSummaryCubit>().state.expensePercentages;
    return Padding(
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
        ],
      ),
    );
  }

  CategoryModel _getCategoryForExpense() {
    return CategoryModel.categories.firstWhere(
      (category) => category.id == expense.categoryId,
    );
  }
}
