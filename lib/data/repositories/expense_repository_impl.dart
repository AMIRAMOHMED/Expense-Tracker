import '../../domain/repositories/expense_repository.dart';
import '../models/expense_model.dart';
import '../sources/expense_local_data_source.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;

  ExpenseRepositoryImpl(this.localDataSource);

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    try {
      return await localDataSource.getExpenses();
    } catch (e) {
      throw Exception('Failed to fetch expenses: $e');
    }
  }

  @override
  Future<ExpenseModel> getExpenseById(int id) async {
    try {
      return await localDataSource.getExpenseById(id);
    } catch (e) {
      throw Exception('Failed to fetch expense by ID $id: $e');
    }
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await localDataSource.addExpense(expense);
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    try {
      await localDataSource.updateExpense(expense);
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  @override
  Future<void> deleteExpense(int id) async {
    try {
      await localDataSource.deleteExpense(id);
    } catch (e) {
      throw Exception('Failed to delete expense ID $id: $e');
    }
  }

  @override
  Future<Map<int, double>> getCategoryMonthlyTotals(int year, int month) async {
    try {
      return await localDataSource.getCategoryMonthlyTotals(year, month);
    } catch (e) {
      throw Exception('Failed to get category totals for $month/$year: $e');
    }
  }

  @override
  Future<List<ExpenseModel>> getExpensesForMonth(int year, int month) async {
    try {
      return await localDataSource.getExpensesForMonth(year, month);
    } catch (e) {
      throw Exception('Failed to get monthly expenses for $month/$year: $e');
    }
  }

  @override
  Future<double> getMonthlyTotal(int year, int month) async {
    try {
      return await localDataSource.getMonthlyTotal(year, month);
    } catch (e) {
      throw Exception('Failed to get monthly total for $month/$year: $e');
    }
  }

  @override
  Future<List<ExpenseModel>> searchExpenses({
    String? query,
    int? categoryId,
    DateTime? date,
  }) async {
    try {
      return await localDataSource.searchExpenses(
        query: query,
        categoryId: categoryId,
        date: date,
      );
    } catch (e) {
      throw Exception('Failed to search expenses: $e');
    }
  }

  @override
  Future<double> getYearlyTotal(int year) async {
    try {
      return await localDataSource.getYearlyTotal(year);
    } catch (e) {
      throw Exception('Failed to get yearly total for $year: $e');
    }
  }
}
