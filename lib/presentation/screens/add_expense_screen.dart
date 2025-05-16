import 'package:flutter/material.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../widgets/AddExpenseScreen/add_expense_form.dart';
import '../widgets/AddExpenseScreen/add_expenses_listener.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteFF,
        appBar: AppBar(
          title: Text(
            "Add Expense",
            style: TextStyles.title.copyWith(color: AppColors.primaryColor),
          ),
        ),
        body: AddExpensesListener(child: AddExpenseForm()),
      ),
    );
  }
}
