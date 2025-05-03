import 'package:get/get.dart';
import 'package:zhige_flutter_tempate/models/todo.dart';
import 'package:zhige_flutter_tempate/repository/todo_repository.dart';

class TodoController extends GetxController {
  final TodoRepository _repository;
  
  // 响应式变量
  final todos = <Todo>[].obs;
  final isLoading = false.obs;

  TodoController({TodoRepository? repository})
      : _repository = repository ?? TodoRepository();

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    isLoading.value = true;
    try {
      final result = await _repository.getAll();
      todos.value = result;
    } catch (e) {
      print('获取任务列表出错: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTodo(String title, {String? description}) async {
    final todo = Todo.create(
      title: title,
      description: description,
    );
    
    try {
      final id = await _repository.save(todo);
      if (id > 0) {
        // 重新获取列表
        await fetchTodos();
      }
    } catch (e) {
      print('添加任务出错: $e');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _repository.save(todo);
      await fetchTodos();
    } catch (e) {
      print('更新任务出错: $e');
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await _repository.delete(id);
      await fetchTodos();
    } catch (e) {
      print('删除任务出错: $e');
    }
  }

  Future<void> toggleTodoStatus(int id) async {
    try {
      await _repository.toggleComplete(id);
      await fetchTodos();
    } catch (e) {
      print('切换任务状态出错: $e');
    }
  }

  Future<List<Todo>> getCompletedTodos() async {
    return await _repository.getCompleted();
  }

  Future<List<Todo>> getUncompletedTodos() async {
    return await _repository.getUncompleted();
  }
} 