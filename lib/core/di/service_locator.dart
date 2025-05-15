import 'package:expense_tracker/domain/logic/expense_summary_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/expense_repository_impl.dart';
import '../../data/sources/expense_local_data_source.dart';
import '../../data/sources/expense_local_data_source_impl.dart';
import '../../domain/helper/expense_calculator.dart';
import '../../domain/logic/add_expense_cubit.dart';
import '../../domain/logic/expense_cubit.dart';
import '../../domain/repositories/expense_repository.dart';
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
  getIt.registerFactory<ExpenseCubit>(() => ExpenseCubit(getIt()));
  getIt.registerSingleton<ExpenseCalculator>(
    ExpenseCalculator(getIt<ExpenseLocalDataSource>()),
  );
  getIt.registerFactory<ExpenseSummaryCubit>(() => ExpenseSummaryCubit(getIt()));
}
