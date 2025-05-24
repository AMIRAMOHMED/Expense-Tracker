import '../repositories/expense_repository.dart';

class GetCategoryMonthlyTotalsUseCase {
  final ExpenseRepository repository;

  GetCategoryMonthlyTotalsUseCase(this.repository);

  Future<Map<int, double>> call(int year, int month) async {
    return await repository.getCategoryMonthlyTotals(year, month);
  }
}
