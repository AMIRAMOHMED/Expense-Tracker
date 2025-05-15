import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/expense_summary_repository.dart';
import 'expense_summary_state.dart';

class ExpenseSummaryCubit extends Cubit<ExpenseSummaryState> {
  final ExpenseSummaryRepository repository;

  ExpenseSummaryCubit(this.repository) : super(const ExpenseSummaryState());

  Future<void> fetchTotalExpenses() async {
    emit(
      state.copyWith(isTotalExpensesLoading: true, totalExpensesError: null),
    );

    try {
      final totalExpenses = await repository.getTotalExpenses();
      emit(
        state.copyWith(
          totalExpenses: totalExpenses,
          isTotalExpensesLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isTotalExpensesLoading: false,
          totalExpensesError: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchExpensePercentages() async {
    emit(
      state.copyWith(
        isExpensePercentagesLoading: true,
        expensePercentagesError: null,
      ),
    );

    try {
      final expensePercentages = await repository.getExpensePercentages();
      print("Expense Percentages: $expensePercentages" );
      emit(
        state.copyWith(
          expensePercentages: expensePercentages,
          isExpensePercentagesLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isExpensePercentagesLoading: false,
          expensePercentagesError: e.toString(),
        ),
      );
    }
  }
}
