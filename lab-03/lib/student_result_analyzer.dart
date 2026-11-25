class Student {
  const Student(this.name, this.marks);
  final String name;
  final List<double> marks;
  double get total => marks.fold(0.0, (sum, mark) => sum + mark);
  double get average => marks.isEmpty ? 0 : total / marks.length;
  String get status => average >= 50 ? 'Pass' : 'Fail';
  String get grade => letterGrade(average);
}

class StudentProfile {
  const StudentProfile(this.name, this.department, this.semester);
  final String name;
  final String department;
  final int semester;
  void displayInfo() => print('$name • $department • Semester $semester');
}

String letterGrade(double score) {
  if (score >= 90) return 'A';
  if (score >= 80) return 'B';
  if (score >= 70) return 'C';
  if (score >= 60) return 'D';
  return score >= 50 ? 'E' : 'F';
}

void main() {
  final name = 'Sample student'; // Inferred String.
  final age = 21; // Inferred int.
  const semester = 7;
  const double gpa = 3.4;
  const bool active = true;
  print('$name • Age $age • Semester $semester • GPA $gpa • Active: $active');
  print(
    'Next age: ${age + 1}, previous semester: ${semester - 1}, doubled GPA: ${gpa * 2}',
  );
  print('Eligible: ${age >= 18 && active}');
  const mark = 84.0;
  print(
    'Mark $mark: ${mark >= 50 ? 'Pass' : 'Fail'}, grade ${letterGrade(mark)}',
  );
  for (var number = 1; number <= 20; number++) {
    print(number);
  }
  var even = 2;
  while (even <= 20) {
    print(even);
    even += 2;
  }
  final courses = ['Flutter', 'Databases', 'Networks', 'Web', 'Algorithms'];
  print('First: ${courses.first}, last: ${courses.last}');
  courses.add('Testing');
  courses.remove('Web');
  print('Has Flutter: ${courses.contains('Flutter')}');
  for (final course in courses) {
    print(course);
  }
  const profiles = [
    StudentProfile('Amina', 'Software Engineering', 7),
    StudentProfile('Omar', 'Information Systems', 7),
    StudentProfile('Maryam', 'Computer Science', 6),
  ];
  for (final profile in profiles) {
    profile.displayInfo();
  }
  final student = Student(name, [78, 86, 92]);
  print(
    '${student.name}: total ${student.total}, average ${student.average.toStringAsFixed(1)}, ${student.status}, grade ${student.grade}',
  );
}
