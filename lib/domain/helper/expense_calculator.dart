import '../../data/sources/expense_local_data_source.dart';

class ExpenseCalculator {
  final ExpenseLocalDataSource dataSource;

  ExpenseCalculator(this.dataSource);

  Future<double> getTotalExpenses() async {
    final expenses = await dataSource.getExpenses();
    return expenses.fold<double>(0.0, (sum, expense) => sum + expense.amount);
  }

  Future<Map<int, double>> getExpensePercentages() async {
    final expenses = await dataSource.getExpenses();
    if (expenses.isEmpty) return {};

    final total = expenses.fold(0.0, (sum, e) => sum + e.amount);
    if (total == 0) return {};

    final percentageMap = <int, double>{};

    for (final expense in expenses) {
      percentageMap[expense.id!] = (expense.amount / total) * 100;
    }

    return percentageMap;
  }
}
