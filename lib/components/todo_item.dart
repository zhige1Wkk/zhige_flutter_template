import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zhige_flutter_tempate/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black26
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onEdit,
          splashColor: theme.colorScheme.primary.withOpacity(0.1),
          highlightColor: theme.colorScheme.primary.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 完成状态复选框
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                        value: todo.completed,
                        onChanged: (_) => onToggle(),
                        activeColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // 标题和描述
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              decoration: todo.completed
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: todo.completed
                                  ? theme.textTheme.bodyLarge?.color?.withOpacity(0.6)
                                  : theme.textTheme.bodyLarge?.color,
                              letterSpacing: 0.2,
                            ),
                          ),
                          if (todo.description != null && todo.description!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 4),
                              child: Text(
                                todo.description!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                                  decoration: todo.completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  height: 1.4,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // 时间信息
                Padding(
                  padding: const EdgeInsets.only(left: 48, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 14,
                            color: theme.colorScheme.primary.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(todo.createdAt),
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                            ),
                          ),
                          if (todo.completed && todo.completedAt != null) ...[
                            const SizedBox(width: 12),
                            Icon(
                              Icons.done_all_rounded,
                              size: 14,
                              color: Colors.green.withOpacity(0.8),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatDate(todo.completedAt!),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.green.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ],
                      ),
                      
                      // 操作按钮
                      Row(
                        children: [
                          _buildIconButton(
                            theme,
                            icon: Icons.edit_rounded,
                            color: theme.colorScheme.primary,
                            onTap: onEdit,
                          ),
                          _buildIconButton(
                            theme,
                            icon: Icons.delete_rounded,
                            color: theme.colorScheme.error,
                            onTap: onDelete,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(
    ThemeData theme, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 20,
            color: color,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd HH:mm').format(date);
  }
} 