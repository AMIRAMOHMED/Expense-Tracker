import '../../data/models/expense_model.dart';
import '../repositories/expense_repository.dart';

class GetExpensesUseCase {
  final ExpenseRepository repository;

  GetExpensesUseCase(this.repository);

  Future<List<ExpenseModel>> call() async {
    return await repository.getExpenses();
  }
}
