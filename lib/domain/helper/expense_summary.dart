import '../../data/models/expense_model.dart';

class ExpenseSummary {
  final List<ExpenseModel> expenses;
  late final double monthlySpending;
  late final double yearlySpending;
  late final Map<int, double> categoryTotals;

  ExpenseSummary(this.expenses) {
    final now = DateTime.now();

    // Monthly spending
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    monthlySpending = expenses
        .where((e) =>
    DateTime.parse(e.date).isAfter(firstDayOfMonth) &&
        DateTime.parse(e.date).isBefore(lastDayOfMonth))
        .fold(0.0, (sum, e) => sum + e.amount);

    // Yearly spending
    final currentYear = now.year;
    yearlySpending = expenses
        .where((e) => DateTime.parse(e.date).year == currentYear)
        .fold(0.0, (sum, e) => sum + e.amount);

    // Category totals
    categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals[expense.categoryId] =
          (categoryTotals[expense.categoryId] ?? 0) + expense.amount;
    }
  }
}