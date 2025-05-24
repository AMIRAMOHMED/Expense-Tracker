import '../../data/models/expense_model.dart';
import '../repositories/expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  Future<void> call(ExpenseModel expense) async {
    await repository.addExpense(expense);
  }
}
