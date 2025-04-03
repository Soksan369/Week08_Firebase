import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../dto/student_dto.dart';
import '../models/student.dart';
import 'student_repository.dart';

class FirebaseStudentsRepository extends StudentRepository  {
  static const String baseUrl = 'https://week8-student-4126b-default-rtdb.firebaseio.com/students';
  static const String studentCollection = "student";
  static const String stuUrl = '$baseUrl/$studentCollection.json';

  @override
  Future<Student> addStudent({required String firstName, required String gender, required String lastName}) async {
    Uri uri = Uri.parse(stuUrl);
    final newStudentData = {'firstName': firstName, 'gender': gender, 'lastName': lastName};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newStudentData),
    );

    if (response.statusCode != HttpStatus.ok && response.statusCode != HttpStatus.created) {
      throw Exception('Failed to add student');
    }
    final newId = json.decode(response.body)['name'];
    return Student(id: newId, firstName: firstName, gender: gender, lastName: lastName);
  }

  @override
  Future<List<Student>> getStudent() async {
    Uri uri = Uri.parse(stuUrl);
    final http.Response response = await http.get(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to load students');
    }
    final data = json.decode(response.body) as Map<String, dynamic>?;
    if (data == null) return [];
    return data.entries.map((entry) => StudentDto.fromJson(entry.key, entry.value)).toList();
  }

  @override
  Future<Student> updateStudent({required Student student}) async {
    final updateUrl = '$baseUrl/$studentCollection/${student.id}.json';
    final uri = Uri.parse(updateUrl);
    final http.Response response = await http.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(StudentDto.toJson(student)),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to update student');
    }
    return student;
  }

  @override
  Future<void> deleteStudent({required String id}) async {
    final deleteUrl = '$baseUrl/$studentCollection/$id.json';
    final uri = Uri.parse(deleteUrl);
    final http.Response response = await http.delete(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to delete student');
    }
  }
}
