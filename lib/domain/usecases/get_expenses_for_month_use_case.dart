import '../../data/models/expense_model.dart';
import '../repositories/expense_repository.dart';

class GetExpensesForMonthUseCase {
  final ExpenseRepository repository;

  GetExpensesForMonthUseCase(this.repository);

  Future<List<ExpenseModel>> call(int year, int month) async {
    return await repository.getExpensesForMonth(year, month);
  }
}
