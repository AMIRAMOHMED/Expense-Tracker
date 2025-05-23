import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import '../repositories/expense_repository.dart';
import 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final ExpenseRepository repository;

  AddExpenseCubit(this.repository) : super(const AddExpenseState());

  Future<void> addExpense(ExpenseModel expense) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    try {
   await repository.addExpense(expense);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void reset() {
    emit(const AddExpenseState());
  }
}
