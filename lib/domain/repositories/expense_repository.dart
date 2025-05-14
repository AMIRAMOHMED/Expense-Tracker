import '../../data/models/expense_model.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseModel>> getExpenses({
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<ExpenseModel> getExpenseById(int id);

  Future<void> addExpense(ExpenseModel expense);

  Future<void> updateExpense(ExpenseModel expense);

  Future<void> deleteExpense(int id);
}
