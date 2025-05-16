import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository_impl.dart';
import 'package:expense_tracker/data/sources/expense_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ExpenseLocalDataSource])
import 'expense_repository_impl_test.mocks.dart';

void main() {
  late ExpenseRepositoryImpl repository;
  late MockExpenseLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockExpenseLocalDataSource();
    repository = ExpenseRepositoryImpl(mockLocalDataSource);
  });

  group('getExpenses', () {
    test('without filters returns all expenses', () async {
      final expenses = [
        ExpenseModel(id: 1, name: 'Coffee', amount: 5.0, date: '2023-01-01', categoryId: 1),
        ExpenseModel(id: 2, name: 'Lunch', amount: 15.0, date: '2023-01-02', categoryId: 2),
      ];
      when(mockLocalDataSource.getExpenses()).thenAnswer((_) async => expenses);
      final result = await repository.getExpenses();
      expect(result, equals(expenses));
    });

    test('with search query filters by name', () async {
      final expenses = [
        ExpenseModel(id: 1, name: 'Coffee', amount: 5.0, date: '2023-01-01', categoryId: 1),
        ExpenseModel(id: 2, name: 'Tea', amount: 3.0, date: '2023-01-02', categoryId: 2),
        ExpenseModel(id: 3, name: 'Coke', amount: 2.0, date: '2023-01-03', categoryId: 3),
      ];
      when(mockLocalDataSource.getExpenses()).thenAnswer((_) async => expenses);
      final result = await repository.getExpenses(searchQuery: 'Co');
      expect(result, [expenses[0], expenses[2]]);
    });

    test('returns empty list when no expenses exist', () async {
      when(mockLocalDataSource.getExpenses()).thenAnswer((_) async => []);
      final result = await repository.getExpenses();
      expect(result, isEmpty);
    });
  });

  group('getExpenseById', () {
    test('returns the correct expense', () async {
      final expense = ExpenseModel(id: 1, name: 'Coffee', amount: 5.0, date: '2023-01-01', categoryId: 8);
      when(mockLocalDataSource.getExpenseById(1)).thenAnswer((_) async => expense);
      final result = await repository.getExpenseById(1);
      expect(result, equals(expense));
    });

    test('throws exception when expense not found', () async {
      when(mockLocalDataSource.getExpenseById(999)).thenThrow(Exception('Not found'));
      expect(() async => await repository.getExpenseById(999), throwsException);
    });
  });

  group('CRUD Operations', () {
    final testExpense = ExpenseModel(id: 1, name: 'Coffee', amount: 5.0, date: '2023-01-01', categoryId: 1);

    test('addExpense adds the expense and it can be retrieved', () async {
      when(mockLocalDataSource.addExpense(testExpense)).thenAnswer((_) async {});
      when(mockLocalDataSource.getExpenses()).thenAnswer((_) async => [testExpense]);

      await repository.addExpense(testExpense);
      final expenses = await repository.getExpenses();

      expect(expenses, contains(testExpense));
      verify(mockLocalDataSource.addExpense(testExpense)).called(1);
    });

    test('deleteExpense removes the expense', () async {
      when(mockLocalDataSource.deleteExpense(1)).thenAnswer((_) async {});
      when(mockLocalDataSource.getExpenses()).thenAnswer((_) async => []);

      await repository.deleteExpense(1);
      final expenses = await repository.getExpenses();

      expect(expenses, isEmpty);
      verify(mockLocalDataSource.deleteExpense(1)).called(1);
    });
  });
}