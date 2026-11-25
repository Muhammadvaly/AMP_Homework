import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ProfilePage()));

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const name = 'Amina Rahimi';
    const description =
        'Software engineering student interested in accessible mobile interfaces, local-first apps, and practical software testing.';
    return Scaffold(
      appBar: AppBar(title: const Text('Student profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(child: Icon(Icons.person_outline)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: theme.textTheme.headlineSmall),
                              const Text('S-101 • Software Engineering'),
                              const Text('Semester 7'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Advanced Mobile Programming',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          semanticsLabel: description,
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            style: theme.textTheme.bodyMedium,
                            children: const [
                              TextSpan(text: 'Course '),
                              TextSpan(
                                text: 'CS.SE.0731',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ' • Active'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.email_outlined),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'amina.mobile.programming@example.com',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.phone_outlined),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text('Contact through the department'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  for (final topic in const [
                    'SafeArea',
                    'Container',
                    'Text',
                    'RichText',
                    'Row',
                    'Column',
                    'Expanded',
                  ])
                    ListTile(
                      leading: const Icon(Icons.book_outlined),
                      title: Text(topic),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
