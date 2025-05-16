import '../../data/models/expense_model.dart';

class ExpenseSummary {
  final List<ExpenseModel> expenses;
  late final double monthlySpending;
  late final double yearlySpending;
  late final Map<int, double> categoryTotals;

  ExpenseSummary(this.expenses) {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;
    //Filter expenses by current year and month
    final currentMonthExpenses =
        expenses.where((e) {
          final expenseDate = DateTime.parse(e.date);
          return expenseDate.year == currentYear &&
              expenseDate.month == currentMonth;
        }).toList();
    // Calculate monthly spending
    monthlySpending = currentMonthExpenses.fold(
      0.0,
      (sum, e) => sum + e.amount,
    );
    //yearly spending
    yearlySpending = expenses
        .where((e) => DateTime.parse(e.date).year == currentYear)
        .fold(0.0, (sum, e) => sum + e.amount);
    // category totals

    categoryTotals = {};
    for (var expense in currentMonthExpenses) {
      categoryTotals[expense.categoryId] =
          (categoryTotals[expense.categoryId] ?? 0) + expense.amount;
    }
  }
}
