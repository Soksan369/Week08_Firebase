class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final double score;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.score,
  });

  // Factory method to create Student from JSON
  factory Student.fromJson(String id, Map<String, dynamic> json) {
    return Student(
      id: id,
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      score: json['score']?.toDouble() ?? 0.0,
    );
  }

  // Convert Student object to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'score': score,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Student && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
