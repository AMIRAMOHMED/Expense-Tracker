import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/domain/logic/expense_cubit.dart';
import 'package:expense_tracker/domain/logic/expense_state.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ExpenseRepository])
import 'expense_cubit_test.mocks.dart';

void main() {
  late ExpenseCubit expenseCubit;
  late MockExpenseRepository mockExpenseRepository;

  final expense1 = ExpenseModel(
    id: 1,
    name: 'Food',
    amount: 5.0,
    date: '2025-05-17',
    categoryId: 1,
  );
  final expense2 = ExpenseModel(
    id: 2,
    name: 'Transport And Fuel',
    amount: 15.0,
    date: '2023-05-16',
    categoryId: 2,
  );

  setUp(() {
    mockExpenseRepository = MockExpenseRepository();
    expenseCubit = ExpenseCubit(mockExpenseRepository);
  });

  tearDown(() {
    expenseCubit.close();
  });

  group("loadExpenses", () {
    // Test loading expenses successfully

    blocTest<ExpenseCubit, ExpenseState>(
      "should load expenses successfully",
      build: () => expenseCubit,
      setUp: () {
        when(
          mockExpenseRepository.getExpenses(),
        ).thenAnswer((_) async => [expense1, expense2]);
      },
      act: (expenseCubit) => expenseCubit.loadExpenses(),
      expect:
          () => [
            ExpenseState(expenses: [], isLoading: true),
            ExpenseState(expenses: [expense1, expense2], isLoading: false),

          ],
      verify: (expenseCubit) {
        verify(mockExpenseRepository.getExpenses()).called(1);
      },
    );
    // Test loading expenses fails

    blocTest<ExpenseCubit, ExpenseState>(
      'emits [loading, error] when loadExpenses fails',
      build: () => expenseCubit,
      setUp: () {
        when(mockExpenseRepository.getExpenses())
            .thenThrow(Exception('Network error'));
      },
      act: (cubit) => cubit.loadExpenses(),
      expect: () => [
        const ExpenseState(isLoading: true),
        const ExpenseState(
            isLoading: false, errorMessage: 'Exception: Network error'),
      ],
    );
  });
  
group("addExpense", (){
  // Test adding an expense

  blocTest<ExpenseCubit, ExpenseState>(
    'emits [loading, loaded] when addExpense succeeds',
    build: () => expenseCubit,
    setUp: () {
      when(mockExpenseRepository.addExpense(any)).thenAnswer((_) async {});
      when(mockExpenseRepository.getExpenses())
          .thenAnswer((_) async => [expense1]);
    },
    act: (cubit) => cubit.addExpense(expense1),
    expect: () => [
      const ExpenseState(isLoading: true),
      ExpenseState(expenses: [expense1], isLoading: false),
    ],
    verify: (_) {
      verify(mockExpenseRepository.addExpense(expense1)).called(1);
      verify(mockExpenseRepository.getExpenses()).called(1);
    },
  );
});
  group("deleteExpense", () {
    // Test deleting an expense with a valid ID
    blocTest<ExpenseCubit, ExpenseState>(
      'emits [loading, loaded] when deleteExpense succeeds',
      build: () => expenseCubit,
      setUp: () {
        when(mockExpenseRepository.deleteExpense(any))
            .thenAnswer((_) async => 1);
        when(mockExpenseRepository.getExpenses())
            .thenAnswer((_) async => []);
      },
      act: (cubit) => cubit.deleteExpense(1),
      expect: () => [
        const ExpenseState(isLoading: true),
        ExpenseState(expenses: [], isLoading: false),
      ],
      verify: (_) {
        verify(mockExpenseRepository.deleteExpense(1)).called(1);
        verify(mockExpenseRepository.getExpenses()).called(1);
      },
    );
    blocTest<ExpenseCubit, ExpenseState>(
      // Test deleting an expense with an invalid ID
      'emits [loading, error] when deleteExpense succeeds',
      build: () => expenseCubit,
      setUp: () {
        when(mockExpenseRepository.deleteExpense(99))
            .thenAnswer((_) async => 0);
        when(mockExpenseRepository.getExpenses())
            .thenAnswer((_) async => [ expense2 , expense1]);
      },
      act: (cubit) => cubit.deleteExpense(99),
      expect: () => [
        const ExpenseState(isLoading: true),
        ExpenseState(expenses: [expense2 , expense1], isLoading: false),
      ],
      verify: (_) {
        verify(mockExpenseRepository.deleteExpense(99)).called(1);
        verify(mockExpenseRepository.getExpenses()).called(1);
      },
    );
  });
}
