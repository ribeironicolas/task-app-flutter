import 'package:sqflite/sqflite.dart';
import 'package:task_app/components/task.dart';
import 'package:task_app/data/database.dart';

class TaskDao {
  static const String table = 'CREATE TABLE $_tableName('
      'name TEXT, '
      'difficulty INTEGER, '
      'image TEXT)';

  static const String _tableName = 'tasks';

  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> row in taskMap) {
      final Task task = Task(
        row['name'],
        row['image'],
        row['difficulty'],
      );
      tasks.add(task);
    }
    return tasks;
  }

  Map<String, dynamic> toMap(Task task) {
    return {
      'name': task.name,
      'difficulty': task.difficulty,
      'image': task.photo,
    };
  }

  save(Task task) async {
    final Database db = await getDatabase();
    var itemExists = await find(task.name);
    Map<String, dynamic> taskMap = toMap(task);
    if (itemExists.isEmpty) {
      return await db.insert(_tableName, taskMap);
    } else {
      return await db.update(
        _tableName,
        taskMap,
        where: 'name = ?',
        whereArgs: [task.name],
      );
    }
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return toList(result);
  }

  Future<List<Task>> find(String name) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
    return toList(result);
  }

  delete(String name) async {
    final Database db = await getDatabase();
    return await db.delete(
      _tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}
