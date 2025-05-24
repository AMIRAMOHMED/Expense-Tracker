import '../repositories/expense_repository.dart';

class GetMonthlyTotalUseCase {
  final ExpenseRepository repository;

  GetMonthlyTotalUseCase(this.repository);

  Future<double> call(int year, int month) async {
    return await repository.getMonthlyTotal(year, month);
  }
}
