import '/models/student.dart';

abstract class StudentRepository {
  Future<Student> addStudent({required String firstName, required String gender, required String lastName});
  Future<List<Student>> getStudent();
  Future<Student> updateStudent({required Student student});
  Future<void> deleteStudent({required String id});
}

