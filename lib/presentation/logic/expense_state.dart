import 'package:equatable/equatable.dart';

import '../../data/models/expense_model.dart';

enum ExpenseStatus { initial, loading, loaded, error }

class ExpenseState extends Equatable {
  final ExpenseStatus status;
  final List<ExpenseModel> expenses;
  final double monthlyTotal;
  final double yearlyTotal;
  final Map<int, double> categoryTotals;
  final String? errorMessage;
  final int currentYear;
  final int currentMonth;

  const ExpenseState({
    this.status = ExpenseStatus.initial,
    this.expenses = const [],
    this.monthlyTotal = 0.0,
    this.yearlyTotal = 0.0,
    this.categoryTotals = const {},
    this.errorMessage,
    this.currentYear = 0,
    this.currentMonth = 0,
  });

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<ExpenseModel>? expenses,
    double? monthlyTotal,
    double? yearlyTotal,
    Map<int, double>? categoryTotals,
    String? errorMessage,
    int? currentYear,
    int? currentMonth,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      monthlyTotal: monthlyTotal ?? this.monthlyTotal,
      yearlyTotal: yearlyTotal ?? this.yearlyTotal,
      categoryTotals: categoryTotals ?? this.categoryTotals,
      errorMessage: errorMessage ?? this.errorMessage,
      currentYear: currentYear ?? this.currentYear,
      currentMonth: currentMonth ?? this.currentMonth,
    );
  }

  @override
  List<Object?> get props => [
    status,
    expenses,
    monthlyTotal,
    yearlyTotal,
    categoryTotals,
    errorMessage,
    currentYear,
    currentMonth,
  ];
}
