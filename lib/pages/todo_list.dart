import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zhige_flutter_tempate/components/add_todo_dialog.dart';
import 'package:zhige_flutter_tempate/components/todo_item.dart';
import 'package:zhige_flutter_tempate/controller/todo.dart';
import 'package:zhige_flutter_tempate/models/todo.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find<TodoController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('todo_list'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              todoController.fetchTodos();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (todoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (todoController.todos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'no_todos'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => todoController.fetchTodos(),
          child: ListView.builder(
            itemCount: todoController.todos.length,
            itemBuilder: (context, index) {
              final todo = todoController.todos[index];
              return TodoItem(
                todo: todo,
                onToggle: () {
                  todoController.toggleTodoStatus(todo.id);
                },
                onDelete: () {
                  _showDeleteConfirmationDialog(context, todo);
                },
                onEdit: () {
                  _showEditTodoDialog(context, todo);
                },
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        tooltip: 'add_todo'.tr,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTodoDialog(
          onSave: (title, description) {
            final todoController = Get.find<TodoController>();
            todoController.addTodo(title, description: description);
          },
        );
      },
    );
  }

  void _showEditTodoDialog(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTodoDialog(
          todo: todo,
          onSave: (title, description) {
            final todoController = Get.find<TodoController>();
            final updatedTodo = todo.copyWith(
              title: title,
              description: description,
            );
            todoController.updateTodo(updatedTodo);
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete'.tr),
          content: Text('delete_todo_confirmation'.tr),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: () {
                final todoController = Get.find<TodoController>();
                todoController.deleteTodo(todo.id);
                Navigator.of(context).pop();
                
                Get.snackbar(
                  'success'.tr,
                  'delete_todo_success'.tr,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              child: Text(
                'delete'.tr,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
} 