import '../repositories/expense_repository.dart';

class GetYearlyTotalUseCase {
  final ExpenseRepository repository;

  GetYearlyTotalUseCase(this.repository);

  Future<double> call(int year) async {
    return await repository.getYearlyTotal(year);
  }
}
