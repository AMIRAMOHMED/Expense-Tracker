import 'package:expense_tracker/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theming/colors.dart';
import '../../domain/logic/expense_cubit.dart';
import '../../domain/logic/expense_state.dart';
import '../../domain/logic/expense_summary_cubit.dart';
import '../widgets/EmptySection.dart';
import '../widgets/add_expense_button.dart';
import '../widgets/draggable_expenses.dart';
import '../widgets/expense_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpenseCubit>(
      create: (context) => getIt<ExpenseCubit>()..loadExpenses(),

      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteFF,
          body: BlocBuilder<ExpenseCubit, ExpenseState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              if (state.expenses.isEmpty) {
                return const EmptySection();
              }
              return BlocProvider(
                create:
                    (context) =>
                        getIt<ExpenseSummaryCubit>()
                          ..fetchTotalExpenses()
                          ..fetchExpensePercentages(),
                child: Stack(
                  children: [
                    const Center(child: Text(' Dashboard Screen')),
                    DraggableExpenses(),
                    Positioned(
                      // Modified this section
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: AddExpenseButton(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

