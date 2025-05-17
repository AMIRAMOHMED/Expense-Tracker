import 'package:expense_tracker/core/di/service_locator.dart';
import 'package:expense_tracker/domain/logic/expense_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theming/colors.dart';
import '../../domain/helper/expense_summary.dart';
import '../../domain/logic/expense_cubit.dart';
import '../../domain/logic/expense_state.dart';
import '../widgets/dashboardScreen/dashboard_content.dart';
import '../widgets/dashboardScreen/dashboard_header.dart';
import '../widgets/dashboardScreen/draggable_expenses.dart';
import '../widgets/dashboardScreen/empty_section.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => getIt<ExpenseSummaryCubit>()..fetchExpensePercentages(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteFF,
          body: BlocBuilder<ExpenseCubit, ExpenseState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.expenses.isEmpty) {
                return const EmptySection();
              } else {
                return Column(
                  children: [
                    DashboardHeader(),
                    Expanded(
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            heightFactor: 0.8,
                            child: DashboardContent(
                              summary: ExpenseSummary(state.expenses),
                            ),
                          ),
                          DraggableExpenses(),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
