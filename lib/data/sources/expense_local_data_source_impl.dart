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
    return maps.map((map) => ExpenseModel.fromMap(map)).toList();
  }

  @override
  Future<ExpenseModel> getExpenseById(int id) async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      DatabaseHelper.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ExpenseModel.fromMap(maps.first);
    } else {
      throw Exception('Expense not found');
    }
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    final db = await databaseHelper.database;
    await db.insert(DatabaseHelper.tableName, expense.toMap());
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    final db = await databaseHelper.database;
    await db.update(
      DatabaseHelper.tableName,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  @override
  Future<void> deleteExpense(int id) async {
    final db = await databaseHelper.database;
    await db.delete(DatabaseHelper.tableName, where: 'id = ?', whereArgs: [id]);
  }
}
