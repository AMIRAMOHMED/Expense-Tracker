import '../repositories/expense_repository.dart';

class DeleteExpenseUseCase {
  final ExpenseRepository repository;
  DeleteExpenseUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.deleteExpense(id);
  }
}