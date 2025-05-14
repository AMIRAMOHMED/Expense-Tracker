import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import '../repositories/expense_repository.dart';
import 'expense_state.dart';

class AddExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository repository;

  AddExpenseCubit(this.repository) : super(const ExpenseState());

  Future<void> addExpense(ExpenseModel expense) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.addExpense(expense);
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: 'Failed to add expense'),
      );
    }
  }
}
