import '../../core/exception/expense_not_found_exception.dart';
import '../../core/helper/database_helper.dart';
import '../models/expense_model.dart';
import 'expense_local_data_source.dart';

class ExpenseLocalDataSourceImpl implements ExpenseLocalDataSource {
  final DatabaseHelper databaseHelper;

  ExpenseLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final db = await databaseHelper.database;
    final maps = await db.query(DatabaseHelper.tableName);
    return maps.map((map) => ExpenseModel.fromJson(map)).toList();
  }

  @override
  Future<ExpenseModel> getExpenseById(int id) async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      DatabaseHelper.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      throw ExpenseNotFoundException('Expense with id $id not found');
    }
    return ExpenseModel.fromJson(maps.first);
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    final db = await databaseHelper.database;
    await db.insert(DatabaseHelper.tableName, expense.toJson());
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    final db = await databaseHelper.database;
    final rowsAffected = await db.update(
      DatabaseHelper.tableName,
      expense.toJson(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
    if (rowsAffected == 0) {
      throw ExpenseNotFoundException('Expense with id ${expense.id} not found');
    }
  }

  @override
  Future<void> deleteExpense(int id) async {
    final db = await databaseHelper.database;
    final rowsAffected = await db.delete(
      DatabaseHelper.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (rowsAffected == 0) {
      throw ExpenseNotFoundException('Expense with id $id not found');
    }
  }

  @override
  Future<List<ExpenseModel>> getExpensesForMonth(int year, int month) async {
    final db = await databaseHelper.database;
    final results = await db.query(
      'expenses',
      where: 'strftime("%Y-%m", date) = ?',
      whereArgs: [
        '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}',
      ],
    );
    return results.map((e) => ExpenseModel.fromJson(e)).toList();
  }

  @override
  Future<Map<int, double>> getCategoryMonthlyTotals(int year, int month) async {
    final db = await databaseHelper.database;
    final results = await db.rawQuery(
      '''
      SELECT categoryId, SUM(amount) as total 
      FROM expenses 
      WHERE strftime("%Y-%m", date) = ?
      GROUP BY categoryId
    ''',
      ['${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}'],
    );
    return {
      for (var item in results)
        item['categoryId'] as int: item['total'] as double? ?? 0.0,
    };
  }

  @override
  Future<double> getMonthlyTotal(int year, int month) async {
    final db = await databaseHelper.database;
    final result = await db.rawQuery(
      '''
      SELECT SUM(amount) as total 
      FROM expenses 
      WHERE strftime("%Y-%m", date) = ?
    ''',
      ['${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}'],
    );
    return result.first['total'] as double? ?? 0.0;
  }

  @override
  Future<List<ExpenseModel>> searchExpenses({
    String? query,
    int? categoryId,
    DateTime? date,
  }) async {
    final db = await databaseHelper.database;
    final where = <String>[];
    final args = <dynamic>[];

    if (query != null) {
      where.add('name LIKE ?');
      args.add('%$query%');
    }
    if (categoryId != null) {
      where.add('categoryId = ?');
      args.add(categoryId);
    }
    if (date != null) {
      where.add('date = ?');
      args.add(date.toIso8601String().substring(0, 10));
    }

    final results = await db.query(
      'expenses',
      where: where.isNotEmpty ? where.join(' AND ') : null,
      whereArgs: args,
    );
    return results.map((e) => ExpenseModel.fromJson(e)).toList();
  }

  @override
  Future<double> getYearlyTotal(int year)  async{
    final db = await databaseHelper.database;
    final result = await db.rawQuery(
        'SELECT SUM(amount) as total FROM expenses WHERE strftime("%Y", date) = ?',
        [year.toString()]
    );
    return result.first['total'] as double? ?? 0.0;
  }
}
