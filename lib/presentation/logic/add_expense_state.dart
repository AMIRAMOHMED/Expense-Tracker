import 'package:equatable/equatable.dart';

class AddExpenseState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const AddExpenseState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  AddExpenseState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return AddExpenseState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    errorMessage,
  ];
}
