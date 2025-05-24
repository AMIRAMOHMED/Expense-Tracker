import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/expense_model.dart';
import '../../logic/expense_cubit.dart';

class ExpenseContent extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseContent({required this.expense, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monthlyTotal = context.read<ExpenseCubit>().state.monthlyTotal;

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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${expense.amount} EGP", style: TextStyles.regular),
                  Text(
                    "${((expense.amount / monthlyTotal) * 100).toStringAsFixed(2)}% of total",
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
                onPressed:
                    () => {
                      Navigator.pushNamed(
                        context,

                        Routes.editExpenseScreen,
                        arguments: expense,
                      ),
                    },
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
