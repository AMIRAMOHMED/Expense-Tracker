
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import '../repositories/expense_repository.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository repository;

  ExpenseCubit(this.repository) : super(const ExpenseState());

  Future<void> loadExpenses() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final expenses = await repository.getExpenses(
        searchQuery: state.searchQuery,
        startDate: state.startDate,
        endDate: state.endDate,
      );
      emit(state.copyWith(expenses: expenses, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
    loadExpenses();
  }

  void setDateRange(DateTime start, DateTime end) {
    emit(state.copyWith(startDate: start, endDate: end));
    loadExpenses();
  }

  void clearFilters() {
    emit(state.copyWith(searchQuery: null, startDate: null, endDate: null));
    loadExpenses();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.addExpense(expense);
      await loadExpenses();
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: 'Failed to add expense'),
      );
    }
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.updateExpense(expense);
      await loadExpenses();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to update expense',
        ),
      );
    }
  }

  Future<void> deleteExpense(int id) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.deleteExpense(id);
      await loadExpenses();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to delete expense',
        ),
      );
    }
  }
}
