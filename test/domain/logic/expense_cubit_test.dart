import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/domain/usecases/delete_expense_use_case.dart';
import 'package:expense_tracker/domain/usecases/get_category_monthly_totals_use_case.dart';
import 'package:expense_tracker/domain/usecases/get_expenses_for_month_use_case.dart';
import 'package:expense_tracker/domain/usecases/get_monthly_total_use_case.dart';
import 'package:expense_tracker/domain/usecases/get_yearly_total_use_case.dart';
import 'package:expense_tracker/domain/usecases/update_expense_use_case.dart';
import 'package:expense_tracker/presentation/logic/expense_cubit.dart';
import 'package:expense_tracker/presentation/logic/expense_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  DeleteExpenseUseCase,
  UpdateExpenseUseCase,
  GetExpensesForMonthUseCase,
  GetCategoryMonthlyTotalsUseCase,
  GetMonthlyTotalUseCase,
  GetYearlyTotalUseCase,
])
import 'expense_cubit_test.mocks.dart';

void main() {
  late ExpenseCubit expenseCubit;
  late MockDeleteExpenseUseCase mockDeleteExpenseUseCase;
  late MockUpdateExpenseUseCase mockUpdateExpenseUseCase;
  late MockGetExpensesForMonthUseCase mockGetExpensesForMonthUseCase;
  late MockGetCategoryMonthlyTotalsUseCase mockGetCategoryMonthlyTotalsUseCase;
  late MockGetMonthlyTotalUseCase mockGetMonthlyTotalUseCase;
  late MockGetYearlyTotalUseCase mockGetYearlyTotalUseCase;

  const year = 2023;
  const month = 5;
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
  final categoryTotals = {3: 50.0};
  const monthlyTotal = 100.0;
  const yearlyTotal = 500.0;

  setUp(() {
    mockDeleteExpenseUseCase = MockDeleteExpenseUseCase();
    mockUpdateExpenseUseCase = MockUpdateExpenseUseCase();
    mockGetExpensesForMonthUseCase = MockGetExpensesForMonthUseCase();
    mockGetCategoryMonthlyTotalsUseCase = MockGetCategoryMonthlyTotalsUseCase();
    mockGetMonthlyTotalUseCase = MockGetMonthlyTotalUseCase();
    mockGetYearlyTotalUseCase = MockGetYearlyTotalUseCase();

    expenseCubit = ExpenseCubit(
      deleteExpenseUseCase: mockDeleteExpenseUseCase,
      updateExpenseUseCase: mockUpdateExpenseUseCase,
      getExpensesForMonthUseCase: mockGetExpensesForMonthUseCase,
      getCategoryMonthlyTotalsUseCase: mockGetCategoryMonthlyTotalsUseCase,
      getMonthlyTotalUseCase: mockGetMonthlyTotalUseCase,
      getYearlyTotalUseCase: mockGetYearlyTotalUseCase,
    );
  });

  group("loadExpenses", () {
    blocTest<ExpenseCubit, ExpenseState>(
      "emits [loading, loaded] when successful",
      build: () => expenseCubit,
      setUp: () {
        when(
          mockGetExpensesForMonthUseCase(year, month),
        ).thenAnswer((_) async => [expense1, expense2]);
        when(
          mockGetCategoryMonthlyTotalsUseCase(year, month),
        ).thenAnswer((_) async => categoryTotals);
        when(
          mockGetMonthlyTotalUseCase(year, month),
        ).thenAnswer((_) async => monthlyTotal);
        when(
          mockGetYearlyTotalUseCase(year),
        ).thenAnswer((_) async => yearlyTotal);
      },
      act: (cubit) => cubit.loadExpenses(year, month),
      expect:
          () => [
            const ExpenseState(status: ExpenseStatus.loading),
            ExpenseState(
              status: ExpenseStatus.loaded,
              expenses: [expense1, expense2],
              categoryTotals: categoryTotals,
              monthlyTotal: monthlyTotal,
              yearlyTotal: yearlyTotal,
              currentYear: year,
              currentMonth: month,
            ),
          ],
      verify: (_) {
        verify(mockGetExpensesForMonthUseCase(year, month)).called(1);
        verify(mockGetCategoryMonthlyTotalsUseCase(year, month)).called(1);
        verify(mockGetMonthlyTotalUseCase(year, month)).called(1);
        verify(mockGetYearlyTotalUseCase(year)).called(1);
      },
    );

    blocTest<ExpenseCubit, ExpenseState>(
      "emits [loading, error] when fails",
      build: () => expenseCubit,
      setUp: () {
        when(
          mockGetExpensesForMonthUseCase(year, month),
        ).thenThrow(Exception("Network error"));
      },
      act: (cubit) => cubit.loadExpenses(year, month),
      expect:
          () => [
            const ExpenseState(status: ExpenseStatus.loading),
            ExpenseState(
              status: ExpenseStatus.error,
              errorMessage: "Exception: Network error",
            ),
          ],
    );
  });
  group("deleteExpense", () {
    blocTest<ExpenseCubit, ExpenseState>(
      "emits [loading, loaded] when successful",
      build: () => expenseCubit,
      setUp: () {
        // Mock initial load data
        when(
          mockGetExpensesForMonthUseCase(year, month),
        ).thenAnswer((_) async => [expense1]);
        when(
          mockGetCategoryMonthlyTotalsUseCase(year, month),
        ).thenAnswer((_) async => categoryTotals);
        when(
          mockGetMonthlyTotalUseCase(year, month),
        ).thenAnswer((_) async => monthlyTotal);
        when(
          mockGetYearlyTotalUseCase(year),
        ).thenAnswer((_) async => yearlyTotal);
        when(mockDeleteExpenseUseCase(1)).thenAnswer((_) async {});
      },
      act: (cubit) async {
        await cubit.loadExpenses(year, month);
        when(
          mockGetExpensesForMonthUseCase(year, month),
        ).thenAnswer((_) async => []);
        await cubit.deleteExpense(1);
      },
      skip: 2,
      expect:
          () => [
            ExpenseState(
              status: ExpenseStatus.loading,
              expenses: [expense1],
              categoryTotals: categoryTotals,
              monthlyTotal: monthlyTotal,
              yearlyTotal: yearlyTotal,
              currentYear: year,
              currentMonth: month,
            ),
            ExpenseState(
              status: ExpenseStatus.loaded,
              expenses: [],
              categoryTotals: categoryTotals,
              monthlyTotal: monthlyTotal,
              yearlyTotal: yearlyTotal,
              currentYear: year,
              currentMonth: month,
            ),
          ],
      verify: (_) {
        verify(mockDeleteExpenseUseCase(1)).called(1);
        verify(mockGetExpensesForMonthUseCase(year, month)).called(2);
      },
    );
  });
}
