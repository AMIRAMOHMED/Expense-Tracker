import 'package:expense_tracker/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/logic/expense_cubit.dart';
import '../../domain/logic/expense_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExpenseCubit>()..loadExpenses(),
      child: const SafeArea(child: Scaffold(body: ExpenseDashboard())),
    );
  }
}

class ExpenseDashboard extends StatelessWidget {
  const ExpenseDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        if (state.expenses.isEmpty) {
          return const Center(child: Text('No expenses found'));
        }

        // Print to log for testing
        for (var expense in state.expenses) {
          debugPrint('Expense: ${expense.toString()}');
        }

        return ListView.builder(
          itemCount: state.expenses.length,
          itemBuilder: (context, index) {
            final expense = state.expenses[index];
            return ListTile(
              title: Text(expense.title),
              subtitle: Text('Amount: \$${expense.amount.toString()}'),
            );
          },
        );
      },
    );
  }
}
