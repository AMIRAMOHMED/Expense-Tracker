import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/logic/expense_cubit.dart';
import '../../../domain/logic/expense_state.dart';

class EditExpenseListener extends StatelessWidget {
  final Widget child;

  const EditExpenseListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseCubit, ExpenseState>(
      listener: (context, state) {
        if (!state.isLoading && state.errorMessage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Expense updated successfully')),
          );
          Navigator.pop(context, true);
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: child,
    );
  }
}
