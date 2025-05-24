import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import '../../domain/usecases/delete_expense_use_case.dart';
import '../../domain/usecases/get_category_monthly_totals_use_case.dart';
import '../../domain/usecases/get_expenses_for_month_use_case.dart';
import '../../domain/usecases/get_monthly_total_use_case.dart';
import '../../domain/usecases/get_yearly_total_use_case.dart';
import '../../domain/usecases/update_expense_use_case.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final UpdateExpenseUseCase updateExpenseUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;
  final GetExpensesForMonthUseCase getExpensesForMonthUseCase;
  final GetCategoryMonthlyTotalsUseCase getCategoryMonthlyTotalsUseCase;
  final GetMonthlyTotalUseCase getMonthlyTotalUseCase;
  final GetYearlyTotalUseCase getYearlyTotalUseCase;

  ExpenseCubit({
    required this.deleteExpenseUseCase,
    required this.updateExpenseUseCase,
    required this.getExpensesForMonthUseCase,
    required this.getCategoryMonthlyTotalsUseCase,
    required this.getMonthlyTotalUseCase,
    required this.getYearlyTotalUseCase,
  }) : super(const ExpenseState());

  Future<void> loadExpenses(int year, int month) async {
    emit(state.copyWith(status: ExpenseStatus.loading));
    try {
      final expenses = await getExpensesForMonthUseCase(year, month);
      final categoryTotals = await getCategoryMonthlyTotalsUseCase(year, month);
      final monthlyTotal = await getMonthlyTotalUseCase(year, month);
      final yearlyTotal = await getYearlyTotalUseCase(year);

      emit(
        state.copyWith(
          status: ExpenseStatus.loaded,
          expenses: expenses,
          categoryTotals: categoryTotals,
          monthlyTotal: monthlyTotal,
          currentYear: year,
          yearlyTotal: yearlyTotal,
          currentMonth: month,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ExpenseStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    emit(state.copyWith(status: ExpenseStatus.loading));
    try {
      await updateExpenseUseCase(expense);
      await _reloadCurrentMonthData();
    } catch (e) {
      emit(
        state.copyWith(status: ExpenseStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> deleteExpense(int id) async {
    emit(state.copyWith(status: ExpenseStatus.loading));
    try {
      await deleteExpenseUseCase(id);
      await _reloadCurrentMonthData();
    } catch (e) {
      emit(
        state.copyWith(status: ExpenseStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _reloadCurrentMonthData() async {
    if (state.currentYear > 0 && state.currentMonth > 0) {
      await loadExpenses(state.currentYear, state.currentMonth);
    }
  }
}
