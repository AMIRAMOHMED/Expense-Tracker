import '../models/expense_model.dart';

abstract class ExpenseLocalDataSource {
  Future<List<ExpenseModel>> getExpenses();
  Future<ExpenseModel> getExpenseById(int id);
  Future<void> addExpense(ExpenseModel expense);
  Future<void> updateExpense(ExpenseModel expense);
  Future<void> deleteExpense(int id);
}