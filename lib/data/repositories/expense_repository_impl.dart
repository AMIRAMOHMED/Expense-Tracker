import '../../domain/repositories/expense_repository.dart';
import '../models/expense_model.dart';
import '../sources/expense_local_data_source.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl(this.localDataSource);

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final expenses = await localDataSource.getExpenses();
    return expenses;
  }

  @override
  Future<ExpenseModel> getExpenseById(int id) async {
    return await localDataSource.getExpenseById(id);
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    await localDataSource.addExpense(expense);
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    await localDataSource.updateExpense(expense);
  }

  @override
  Future<void> deleteExpense(int id) async {
    await localDataSource.deleteExpense(id);
  }

  @override
  Future<Map<int, double>> getCategoryMonthlyTotals(int year, int month) async {
    return await localDataSource.getCategoryMonthlyTotals(year, month);
  }

  @override
  Future<List<ExpenseModel>> getExpensesForMonth(int year, int month) async {
    return await localDataSource.getExpensesForMonth(year, month);
  }

  @override
  Future<double> getMonthlyTotal(int year, int month) async {
    return await localDataSource.getMonthlyTotal(year, month);
  }

  @override
  Future<List<ExpenseModel>> searchExpenses({
    String? query,
    int? categoryId,
    DateTime? date,
  }) async {
    return await localDataSource.searchExpenses(
      query: query,
      categoryId: categoryId,
      date: date,
    );
  }

  @override
  Future<double> getYearlyTotal(int year) async {
    return await localDataSource.getYearlyTotal(year);
  }
}
