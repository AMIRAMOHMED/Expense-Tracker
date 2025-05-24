import '../../data/models/expense_model.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseModel>> getExpenses();

  Future<ExpenseModel> getExpenseById(int id);

  Future<void> addExpense(ExpenseModel expense);

  Future<void> updateExpense(ExpenseModel expense);

  Future<void> deleteExpense(int id);

  Future<List<ExpenseModel>> getExpensesForMonth(int year, int month);

  Future<Map<int, double>> getCategoryMonthlyTotals(int year, int month);

  Future<double> getMonthlyTotal(int year, int month);

  Future<List<ExpenseModel>> searchExpenses({
    String? query,
    int? categoryId,
    DateTime? date,
  });
  Future<double> getYearlyTotal(int year);

}
