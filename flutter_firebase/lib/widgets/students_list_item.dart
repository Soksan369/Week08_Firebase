import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentsListItem extends StatelessWidget {
  final Student student;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const StudentsListItem({
    super.key,
    required this.student,
    required this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.firstName),
      subtitle: Text("Last Name: ${student.lastName}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
