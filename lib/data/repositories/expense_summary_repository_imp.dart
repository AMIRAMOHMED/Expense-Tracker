import '../../domain/helper/expense_calculator.dart';
import '../../domain/repositories/expense_summary_repository.dart';

class ExpenseSummaryRepositoryImp implements ExpenseSummaryRepository {
  final ExpenseCalculator calculator;

  ExpenseSummaryRepositoryImp(this.calculator);

  @override
  Future<double> getTotalExpenses() => calculator.getTotalExpenses();

  @override
  Future<Map<int, double>> getExpensePercentages()  => calculator.getExpensePercentages();





}
