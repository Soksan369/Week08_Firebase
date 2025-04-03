class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
  });

  // Factory method to create Student from JSON
  factory Student.fromJson(String id, Map<String, dynamic> json) {
    return Student(
      id: id,
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
    );
  }

  // Convert Student object to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Student && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
