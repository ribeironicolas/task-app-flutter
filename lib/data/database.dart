import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_app/data/task_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(TaskDao.table);
  }, version: 1);
}
