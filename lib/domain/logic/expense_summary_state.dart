import 'package:equatable/equatable.dart';

// Immutable state class for managing expense summary data
class ExpenseSummaryState extends Equatable {
  final Map<int, double>? expensePercentages;
  final bool isExpensePercentagesLoading;
  final String? expensePercentagesError;

  const ExpenseSummaryState({
    this.expensePercentages,
    this.isExpensePercentagesLoading = false,
    this.expensePercentagesError,
  });

  ExpenseSummaryState copyWith({
    Map<int, double>? expensePercentages,
    bool? isExpensePercentagesLoading,
    String? expensePercentagesError,
  }) {
    return ExpenseSummaryState(
      expensePercentages: expensePercentages ?? this.expensePercentages,
      isExpensePercentagesLoading:
          isExpensePercentagesLoading ?? this.isExpensePercentagesLoading,
      expensePercentagesError:
          expensePercentagesError ?? this.expensePercentagesError,
    );
  }

  @override
  List<Object?> get props => [
    expensePercentages,
    isExpensePercentagesLoading,
    expensePercentagesError,
  ];
}
