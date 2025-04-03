import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student.dart';
import '../providers/students_provider.dart';

class StudentFormScreen extends StatefulWidget {
  final Student? student; // If null, it's an add operation; otherwise, it's an edit

  const StudentFormScreen({super.key, this.student});

  @override
  _StudentFormScreenState createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;
  late String _gender;

  @override
  void initState() {
    super.initState();
    _firstName = widget.student?.firstName ?? '';
    _lastName = widget.student?.lastName ?? '';
    _gender = widget.student?.gender ?? ''; // Initialize gender
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final studentProvider = Provider.of<StudentsProvider>(context, listen: false);
      if (widget.student == null) {
        // Add new student
        await studentProvider.addStudent(_firstName, _gender, _lastName);
      } else {
        // Update existing student
        final updatedStudent = Student(
          id: widget.student!.id,
          firstName: _firstName,
          gender: _gender,
          lastName: _lastName,
        );
        await studentProvider.updateStudent(updatedStudent);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Student" : "Add Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _firstName,
                decoration: const InputDecoration(labelText: "First Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a first name";
                  }
                  return null;
                },
                onSaved: (value) => _firstName = value!,
              ),
              TextFormField(
                initialValue: _lastName,
                decoration: const InputDecoration(labelText: "Last Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a last name";
                  }
                  return null;
                },
                onSaved: (value) => _lastName = value!,
              ),
              TextFormField(
                initialValue: _gender,
                decoration: const InputDecoration(labelText: "Gender"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter gender";
                  }
                  return null;
                },
                onSaved: (value) => _gender = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEditing ? Colors.orange : Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black45,
                ),
                child: Text(
                  isEditing ? "Edit" : "Add",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
