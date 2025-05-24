import 'package:get_it/get_it.dart';

import '../../data/repositories/expense_repository_impl.dart';
import '../../data/sources/expense_local_data_source.dart';
import '../../data/sources/expense_local_data_source_impl.dart';
import '../../domain/repositories/expense_repository.dart';
import '../../domain/usecases/add_expense_use_case.dart';
import '../../domain/usecases/delete_expense_use_case.dart';
import '../../domain/usecases/get_category_monthly_totals_use_case.dart';
import '../../domain/usecases/get_expenses_for_month_use_case.dart';
import '../../domain/usecases/get_expenses_use_case.dart';
import '../../domain/usecases/get_monthly_total_use_case.dart';
import '../../domain/usecases/get_yearly_total_use_case.dart';
import '../../domain/usecases/search_expenses_use_case.dart';
import '../../domain/usecases/update_expense_use_case.dart';
import '../../presentation/logic/add_expense_cubit.dart';
import '../../presentation/logic/expense_cubit.dart';
import '../helper/database_helper.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<DatabaseHelper>(DatabaseHelper());
  getIt.registerSingleton<ExpenseLocalDataSource>(
    ExpenseLocalDataSourceImpl(getIt<DatabaseHelper>()),
  );
  getIt.registerSingleton<ExpenseRepository>(
    ExpenseRepositoryImpl(getIt<ExpenseLocalDataSource>()),
  );
  getIt.registerFactory<AddExpenseCubit>(() => AddExpenseCubit(getIt()));
  getIt.registerFactory<ExpenseCubit>(
    () => ExpenseCubit(
      deleteExpenseUseCase: getIt<DeleteExpenseUseCase>(),
      updateExpenseUseCase: getIt<UpdateExpenseUseCase>(),
      getExpensesForMonthUseCase: getIt<GetExpensesForMonthUseCase>(),
      getCategoryMonthlyTotalsUseCase: getIt<GetCategoryMonthlyTotalsUseCase>(),
      getMonthlyTotalUseCase: getIt<GetMonthlyTotalUseCase>(),
      getYearlyTotalUseCase: getIt<GetYearlyTotalUseCase>(),
    ),
  );

  getIt.registerLazySingleton<GetExpensesUseCase>(
    () => GetExpensesUseCase(getIt<ExpenseRepository>()),
  );

  getIt.registerLazySingleton<AddExpenseUseCase>(
    () => AddExpenseUseCase(getIt<ExpenseRepository>()),
  );

  getIt.registerLazySingleton<UpdateExpenseUseCase>(
    () => UpdateExpenseUseCase(getIt<ExpenseRepository>()),
  );

  getIt.registerLazySingleton<DeleteExpenseUseCase>(
    () => DeleteExpenseUseCase(getIt<ExpenseRepository>()),
  );

  getIt.registerLazySingleton<GetExpensesForMonthUseCase>(
    () => GetExpensesForMonthUseCase(getIt<ExpenseRepository>()),
  );

  getIt.registerLazySingleton<GetCategoryMonthlyTotalsUseCase>(
    () => GetCategoryMonthlyTotalsUseCase(getIt<ExpenseRepository>()),
  );

  getIt.registerLazySingleton<GetMonthlyTotalUseCase>(
    () => GetMonthlyTotalUseCase(getIt<ExpenseRepository>()),
  );

  getIt.registerLazySingleton<SearchExpensesUseCase>(
    () => SearchExpensesUseCase(getIt<ExpenseRepository>()),
  );

  getIt.registerLazySingleton<GetYearlyTotalUseCase>(
    () => GetYearlyTotalUseCase(getIt<ExpenseRepository>()),
  );
}
