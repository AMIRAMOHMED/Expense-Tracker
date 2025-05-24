import '../../data/models/expense_model.dart';
import '../repositories/expense_repository.dart';

class SearchExpensesUseCase {
  final ExpenseRepository repository;

  SearchExpensesUseCase(this.repository);

  Future<List<ExpenseModel>> call({
    String? query,
    int? categoryId,
    DateTime? date,
  }) async {
    return await repository.searchExpenses(
      query: query,
      categoryId: categoryId,
      date: date,
    );
  }
}
