import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zhige_flutter_tempate/models/todo.dart';

class TodoRepository {
  late Future<Isar> db;

  TodoRepository() {
    db = openDatabase();
  }

  Future<Isar> openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [TodoSchema],
      directory: dir.path,
    );
  }

  Future<List<Todo>> getAll() async {
    final isar = await db;
    return await isar.todos.where().sortByCreatedAtDesc().findAll();
  }

  Future<List<Todo>> getCompleted() async {
    final isar = await db;
    return await isar.todos.where().filter().completedEqualTo(true).sortByCreatedAtDesc().findAll();
  }

  Future<List<Todo>> getUncompleted() async {
    final isar = await db;
    return await isar.todos.where().filter().completedEqualTo(false).sortByCreatedAtDesc().findAll();
  }

  Future<Todo?> get(int id) async {
    final isar = await db;
    return await isar.todos.get(id);
  }

  Future<int> save(Todo todo) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.todos.put(todo);
    });
  }

  Future<bool> delete(int id) async {
    final isar = await db;
    return await isar.writeTxn(() async {
      return await isar.todos.delete(id);
    });
  }

  Future<void> toggleComplete(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final todo = await isar.todos.get(id);
      if (todo != null) {
        todo.toggleComplete();
        await isar.todos.put(todo);
      }
    });
  }
} 