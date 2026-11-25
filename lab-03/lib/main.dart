import 'package:flutter/material.dart';
import 'student_result_analyzer.dart' show Student;

void main() => runApp(const MaterialApp(home: ResultsPage()));

class ResultsPage extends StatelessWidget {
  const ResultsPage({
    super.key,
    this.course = 'Flutter',
    this.semester = 7,
    this.active = true,
  });
  final String course;
  final int semester;
  final bool active;

  @override
  Widget build(BuildContext context) {
    const topics = ['Variables', 'Lists', 'Classes'];
    const student = Student('Sample student', [78, 86, 92]);
    return Scaffold(
      appBar: AppBar(title: const Text('Student result analyzer')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$course • Semester $semester'),
              Text('Current topic: ${topics[1]}'),
              Text(active ? 'Active' : 'Inactive'),
              Text(student.name),
              Text('Average: ${student.average.toStringAsFixed(1)}'),
              Text('${student.status} • Grade ${student.grade}'),
            ],
          ),
        ),
      ),
    );
  }
}
