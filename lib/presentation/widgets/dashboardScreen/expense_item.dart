import 'package:flutter/material.dart';

import '../../../data/models/expense_model.dart';
import 'dismissible_wrapper.dart';
import 'expense_content.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return DismissibleWrapper(
      expense: expense,
      child: ExpenseContent(expense: expense),
    );
  }
}
