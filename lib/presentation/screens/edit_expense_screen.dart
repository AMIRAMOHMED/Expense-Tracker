import 'package:expense_tracker/core/theming/colors.dart';
import 'package:expense_tracker/core/theming/styles.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:flutter/material.dart';

import '../widgets/EditExpenseScreen/edit_expense_form.dart';
import '../widgets/EditExpenseScreen/edit_expense_listener.dart';

class EditExpenseScreen extends StatelessWidget {
  final ExpenseModel expense;

  const EditExpenseScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return EditExpenseListener(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteFF,
          appBar: AppBar(
            title: Text(
              "Edit Expense",
              style: TextStyles.title.copyWith(color: AppColors.primaryColor),
            ),
          ),
          body: EditExpenseForm(expense: expense),
        ),
      ),
    );
  }
}
