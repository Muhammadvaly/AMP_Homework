import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const CourseApp());

class CourseApp extends StatelessWidget {
  const CourseApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Course welcome',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
    ),
    home: const WelcomePage(),
  );
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Course welcome')),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hello, World!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text(
              'Advanced Mobile Programming',
              textAlign: TextAlign.center,
            ),
            const Text('CS.SE.0731 • Semester 7'),
            Text('Today is ${DateFormat.yMMMMd().format(DateTime.now())}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => count++),
              child: Text('Practice attempts: $count'),
            ),
            const SizedBox(height: 12),
            Theme(
              data: Theme.of(context).copyWith(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade800,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              child: ElevatedButton(
                onPressed: () => setState(() => count = 0),
                child: const Text('Reset attempts'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
