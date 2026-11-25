import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MaterialApp(home: RegistrationPage()));

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final form = GlobalKey<FormState>();
  late final assetInfo = rootBundle.loadString('assets/data/info.txt');
  String department = 'Software Engineering';
  String name = '', email = '', id = '';
  bool ready = false;
  static const departments = [
    'Software Engineering',
    'Computer Science',
    'Information Systems',
  ];

  String? requiredValue(String? input) =>
      (input ?? '').trim().isEmpty ? 'Enter a value' : null;

  void submit() {
    if (!form.currentState!.validate()) return;
    form.currentState!.save();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration complete'),
        content: Text('$name\n$id\n$email\n$department'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/campus.png',
          height: 120,
          fit: BoxFit.contain,
        ),
        const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.school),
          title: Text('Student registration'),
        ),
        FutureBuilder<String>(
          future: assetInfo,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return const Text('Course information could not load.');
            return Text(snapshot.data ?? 'Loading course information…');
          },
        ),
        const SizedBox(height: 12),
        Image.network(
          'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Text('Network image unavailable.'),
        ),
      ],
    );
    final fields = Form(
      key: form,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full name',
              prefixIcon: Icon(Icons.person),
            ),
            validator: requiredValue,
            onSaved: (value) => name = value!.trim(),
            onChanged: (value) =>
                setState(() => ready = value.trim().isNotEmpty),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) =>
                RegExp(
                  r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                ).hasMatch(value?.trim() ?? '')
                ? null
                : 'Enter a valid email',
            onSaved: (value) => email = value!.trim(),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Student ID',
              prefixIcon: Icon(Icons.badge),
            ),
            validator: requiredValue,
            onSaved: (value) => id = value!.trim(),
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (value) =>
                (value?.length ?? 0) >= 8 ? null : 'Use at least 8 characters',
          ),
          ListTile(
            title: Text(department),
            subtitle: const Text('Department'),
            trailing: PopupMenuButton<String>(
              tooltip: 'Select department',
              initialValue: department,
              onSelected: (value) => setState(() => department = value),
              itemBuilder: (_) => [
                for (final value in departments)
                  PopupMenuItem(value: value, child: Text(value)),
              ],
            ),
          ),
          Wrap(
            spacing: 12,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                onPressed: ready ? submit : null,
                child: const Text('Submit'),
              ),
              OutlinedButton(
                onPressed: () {
                  form.currentState!.reset();
                  setState(() {
                    ready = false;
                    department = departments.first;
                  });
                },
                child: const Text('Reset'),
              ),
              TextButton(
                onPressed: () => showAboutDialog(
                  context: context,
                  applicationName: 'Student registration',
                ),
                child: const Text('About'),
              ),
            ],
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        actions: [
          IconButton(
            tooltip: 'Registration help',
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'Student registration',
            ),
            icon: const Icon(Icons.help_outline),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Hide keyboard',
        onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const Icon(Icons.keyboard_hide),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 96),
            child: orientation == Orientation.landscape
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: intro),
                      const SizedBox(width: 20),
                      Expanded(child: fields),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [intro, const SizedBox(height: 16), fields],
                  ),
          ),
        ),
      ),
    );
  }
}
