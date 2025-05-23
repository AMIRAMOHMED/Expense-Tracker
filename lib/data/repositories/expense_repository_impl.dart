import '../../domain/repositories/expense_repository.dart';
import '../models/expense_model.dart';
import '../sources/expense_local_data_source.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource localDataSource;
  ExpenseRepositoryImpl(this.localDataSource);

  @override
  Future<List<ExpenseModel>> getExpenses({
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final expenses = await localDataSource.getExpenses();
    return expenses.where((expense) {
      bool matchesSearch =
          searchQuery == null || expense.name.contains(searchQuery);
      DateTime expenseDate = DateTime.parse(expense.date);
      bool matchesDate =
          (startDate == null || expenseDate.compareTo(startDate) >= 0) &&
          (endDate == null || expenseDate.compareTo(endDate) <= 0);
      return matchesSearch && matchesDate;
    }).toList();
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
}
