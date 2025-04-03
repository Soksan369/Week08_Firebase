import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'students_form_screen.dart';
import '../models/student.dart';
import '../providers/students_provider.dart';
import '../widgets/students_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openAddForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StudentFormScreen(),
      ),
    );
  }

  void _openEditForm(BuildContext context, Student student) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentFormScreen(student: student),
      ),
    );
  }

  void _onDeletePressed(BuildContext context, String id) {
    Provider.of<StudentsProvider>(context, listen: false).deleteStudent(id);
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentsProvider>(context);
    Widget content;

    if (studentProvider.isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (studentProvider.hasData) {
      final studentList = studentProvider.studentsState!.data!;
      content = studentList.isEmpty
          ? const Center(child: Text("No students yet"))
          : ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                final student = studentList[index];
                return StudentsListItem(
                  student: student,
                  onDelete: () => _onDeletePressed(context, student.id),
                  onEdit: () => _openEditForm(context, student),
                );
              },
            );
    } else {
      content = const Center(child: Text("Something went wrong"));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Students",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => _openAddForm(context),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: content,
    );
  }
}
