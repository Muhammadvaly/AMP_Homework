import 'package:flutter/material.dart';
import 'course_registration.dart';

void main() => runApp(const MaterialApp(home: RegistrationPage()));

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final registration = Registration(
    student: const Student(
      name: 'Amina',
      id: 'S-101',
      semester: 7,
      department: 'Software Engineering',
    ),
  );
  static const course = Course(title: 'Flutter', credits: 3);

  void register() => setState(() => registration.add(course));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Course registration')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(registration.student.name),
        Text('Total credits: ${registration.credits}'),
        for (final course in registration.courses)
          ListTile(title: Text(course.title)),
        FilledButton(
          onPressed: register,
          child: const Text('Register for Flutter'),
        ),
        OutlinedButton(
          onPressed: () => setState(() => registration.remove(course)),
          child: const Text('Remove Flutter'),
        ),
      ],
    ),
  );
}
