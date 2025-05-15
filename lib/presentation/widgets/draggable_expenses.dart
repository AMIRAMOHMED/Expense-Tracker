import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/logic/expense_cubit.dart';
import 'expense_item.dart';

class DraggableExpenses extends StatelessWidget {
  const DraggableExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = context.read<ExpenseCubit>().state.expenses;
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ListView.builder(
            controller: scrollController,
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              return ExpenseItem(expense: expenses[index]);
            },
          ),
        );
      },
    );
  }
}
