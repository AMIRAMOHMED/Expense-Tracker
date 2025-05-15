import 'package:flutter_bloc/flutter_bloc.dart';

import '../helper/expense_calculator.dart';
import 'expense_summary_state.dart';

class ExpenseSummaryCubit extends Cubit<ExpenseSummaryState> {
  final ExpenseCalculator repository;

  ExpenseSummaryCubit(this.repository) : super(const ExpenseSummaryState());
  Future<void> fetchExpensePercentages() async {
    emit(
      state.copyWith(
        isExpensePercentagesLoading: true,
        expensePercentagesError: null,
      ),
    );

    try {
      final expensePercentages = await repository.getExpensePercentages();
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
