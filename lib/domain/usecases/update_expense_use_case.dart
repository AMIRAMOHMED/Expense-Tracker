import '../../data/models/expense_model.dart';
import '../repositories/expense_repository.dart';

class UpdateExpenseUseCase {
  final ExpenseRepository repository;

  UpdateExpenseUseCase(this.repository);

  Future<void> call(ExpenseModel expense) async {
    await repository.updateExpense(expense);
  }
}
