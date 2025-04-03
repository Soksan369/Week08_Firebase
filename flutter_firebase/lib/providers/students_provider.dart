import 'package:flutter/material.dart';
import '../repositories/student_repository.dart';
import '../models/student.dart';
import '../async_value.dart';

class StudentsProvider extends ChangeNotifier {
  final StudentRepository _repository;
  AsyncValue<List<Student>> studentsState = AsyncValue.loading();  // Default state as loading

  StudentsProvider(this._repository) {
    fetchStudent();
  }

  bool get isLoading =>
      studentsState.state == AsyncValueState.loading;
  bool get hasData =>
      studentsState.state == AsyncValueState.success;
  bool get hasError =>
      studentsState.state == AsyncValueState.error;

  Future<void> fetchStudent() async {
    try {
      studentsState = AsyncValue.loading();
      notifyListeners();
      final students = await _repository.getStudent();
      studentsState = AsyncValue.success(students);
      print("SUCCESS: list size ${students.length}");
    } catch (error) {
      print("ERROR: $error");
      studentsState = AsyncValue.error(error);
    }
    notifyListeners();
  }

  Future<void> addStudent(String firstName, String gender, String lastName, double score) async {
    await _repository.addStudent(firstName: firstName, gender: gender, lastName: lastName, score: score);
    await fetchStudent();  // Fetch updated student list
  }

  Future<void> updateStudent(Student student) async {
    await _repository.updateStudent(student: student);
    await fetchStudent();  // Fetch updated student list
  }

  Future<void> deleteStudent(String id) async {
    await _repository.deleteStudent(id: id);
    await fetchStudent();  // Fetch updated student list
  }
}
