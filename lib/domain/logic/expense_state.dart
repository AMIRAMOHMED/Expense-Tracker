import 'package:equatable/equatable.dart';

import '../../data/models/expense_model.dart';

class ExpenseState extends Equatable {
  final List<ExpenseModel> expenses;
  final bool isLoading;
  final String? errorMessage;
  final String? searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;

  const ExpenseState({
    this.expenses = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery,
    this.startDate,
    this.endDate,
  });

  ExpenseState copyWith({
    List<ExpenseModel>? expenses,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ExpenseState(
      expenses: expenses ?? this.expenses,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [
    expenses,
    isLoading,
    errorMessage,
    searchQuery,
    startDate,
    endDate,
  ];
}
