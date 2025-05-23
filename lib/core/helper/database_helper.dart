import '''
package:path/path.dart''' show join;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'expenses';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'expenses.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            amount REAL,
            date TEXT,  -- Store as YYYY-MM-DD
            categoryId INTEGER
          )''');
        await db.execute(
          'CREATE INDEX idx_category ON $tableName (categoryId)',
        );
        await db.execute('CREATE INDEX idx_date ON $tableName (date)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('CREATE INDEX idx_category ON $tableName (categoryId)');
          db.execute('CREATE INDEX idx_date ON $tableName (date)');
        }
      },
    );
  }
}
