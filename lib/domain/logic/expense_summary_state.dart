import 'package:equatable/equatable.dart';

// Immutable state class for managing expense summary data
class ExpenseSummaryState extends Equatable {
  final double? totalExpenses;
  final bool isTotalExpensesLoading;
  final String? totalExpensesError;
  final Map<int, double>? expensePercentages;
  final bool isExpensePercentagesLoading;
  final String? expensePercentagesError;

  const ExpenseSummaryState({
    this.totalExpenses,
    this.isTotalExpensesLoading = false,
    this.totalExpensesError,
    this.expensePercentages,
    this.isExpensePercentagesLoading = false,
    this.expensePercentagesError,
  });

  ExpenseSummaryState copyWith({
    double? totalExpenses,
    bool? isTotalExpensesLoading,
    String? totalExpensesError,
    Map<int, double>? expensePercentages,
    bool? isExpensePercentagesLoading,
    String? expensePercentagesError,
  }) {
    return ExpenseSummaryState(
      totalExpenses: totalExpenses ?? this.totalExpenses,
      isTotalExpensesLoading:
          isTotalExpensesLoading ?? this.isTotalExpensesLoading,
      totalExpensesError: totalExpensesError ?? this.totalExpensesError,
      expensePercentages: expensePercentages ?? this.expensePercentages,
      isExpensePercentagesLoading:
          isExpensePercentagesLoading ?? this.isExpensePercentagesLoading,
      expensePercentagesError:
          expensePercentagesError ?? this.expensePercentagesError,
    );
  }

  @override
  List<Object?> get props => [
    totalExpenses,
    isTotalExpensesLoading,
    totalExpensesError,
    expensePercentages,
    isExpensePercentagesLoading,
    expensePercentagesError,
  ];
}
