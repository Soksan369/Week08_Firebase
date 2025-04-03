import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/students_provider.dart';  
import 'repositories/student_repository.dart'; 
import 'screens/home_screen.dart'; 
import 'repositories/firebase_students_repository.dart'; 

void main() {
  // Instantiate the correct repository for students
  final StudentRepository repository = FirebaseStudentsRepository(); 
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => StudentsProvider(repository),  
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}
