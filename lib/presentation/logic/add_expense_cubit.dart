import 'dart:math';

import 'package:expense_tracker/domain/usecases/add_expense_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final  AddExpenseUseCase addExpenseUseCase;


  AddExpenseCubit(this.addExpenseUseCase ) : super(const AddExpenseState());

  Future<void> addExpense(ExpenseModel expense) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    try {
   await addExpenseUseCase(expense);
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
