import '/models/student.dart'; 

class StudentDto {
  // Convert JSON to student object
  static Student fromJson(String id, Map<String, dynamic> json) {
    return Student(
      id: id,
      firstName: json['firstName'],
      gender: json['gender'],
      lastName: json['lastName'],
    );
  }

  // Convert student object to JSON (without the ID)
  static Map<String, dynamic> toJson(Student student) {
    return {
      'firstName': student.firstName,
      'gender': student.gender,
      'lastName': student.lastName,
    };
  }
}
