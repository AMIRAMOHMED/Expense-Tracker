import 'package:expense_tracker/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/expense_cubit.dart';
import 'expense_item.dart';

class DraggableExpenses extends StatelessWidget {
  const DraggableExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    final expenses = context.read<ExpenseCubit>().state.expenses;
    return DraggableScrollableSheet(
      initialChildSize: 0.20,
      minChildSize: 0.20,
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
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.grey73,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // ListView for expenses
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: expenses.length,
                  itemBuilder:
                      (context, index) => ExpenseItem(expense: expenses[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
