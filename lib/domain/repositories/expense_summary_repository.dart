abstract class ExpenseSummaryRepository {
  Future<double> getTotalExpenses();

  Future <Map<int, double>> getExpensePercentages();
}
