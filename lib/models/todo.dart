import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;

  late String title;
  
  String? description;
  
  @Index()
  bool completed = false;
  
  @Index()
  DateTime createdAt = DateTime.now();
  
  @Index()
  DateTime? completedAt;

  Todo();
  
  factory Todo.create({
    required String title,
    String? description,
    bool completed = false,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    final todo = Todo()
      ..title = title
      ..description = description
      ..completed = completed
      ..completedAt = completedAt;
    
    if (createdAt != null) {
      todo.createdAt = createdAt;
    }
    
    return todo;
  }
  
  void toggleComplete() {
    completed = !completed;
    completedAt = completed ? DateTime.now() : null;
  }
  
  Todo copyWith({
    String? title,
    String? description,
    bool? completed,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    final todo = Todo()
      ..id = id
      ..title = title ?? this.title
      ..description = description ?? this.description
      ..completed = completed ?? this.completed
      ..createdAt = createdAt ?? this.createdAt
      ..completedAt = completedAt ?? this.completedAt;
    
    return todo;
  }
} 