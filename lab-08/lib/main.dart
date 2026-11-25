import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LoginPage()));

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Student portal')),
    body: Center(
      child: FilledButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(builder: (_) => const Portal()),
        ),
        child: const Text('Enter demo portal'),
      ),
    ),
  );
}

enum Destination { dashboard, courses, profile, settings }

class Portal extends StatefulWidget {
  const Portal({super.key});
  @override
  State<Portal> createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  Destination destination = Destination.dashboard;
  String student = 'Amina', department = 'Software Engineering';

  Future<void> selectDepartment() async {
    final selection = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const DepartmentPage()),
    );
    if (!mounted || selection == null) return;
    setState(() => department = selection);
  }

  Future<void> editProfile() async {
    final name = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => EditProfilePage(name: student)),
    );
    if (!mounted || name == null) return;
    setState(() => student = name);
  }

  @override
  Widget build(BuildContext context) {
    final title =
        destination.name[0].toUpperCase() + destination.name.substring(1);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: destination == Destination.courses
              ? const TabBar(
                  tabs: [
                    Tab(text: 'All', icon: Icon(Icons.list)),
                    Tab(text: 'Active', icon: Icon(Icons.play_circle_outline)),
                    Tab(
                      text: 'Completed',
                      icon: Icon(Icons.check_circle_outline),
                    ),
                  ],
                )
              : null,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(child: Icon(Icons.school)),
                    const SizedBox(height: 12),
                    Text(student),
                  ],
                ),
              ),
              for (final (page, label, icon) in const [
                (Destination.dashboard, 'Dashboard', Icons.dashboard_outlined),
                (Destination.courses, 'Courses', Icons.menu_book_outlined),
                (Destination.profile, 'Profile', Icons.person_outline),
                (Destination.settings, 'Settings', Icons.settings_outlined),
              ])
                ListTile(
                  leading: Icon(icon),
                  title: Text(label),
                  selected: page == destination,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => destination = page);
                  },
                ),
            ],
          ),
        ),
        body: switch (destination) {
          Destination.dashboard => ListView(
            children: [
              ListTile(
                title: Text('Welcome, $student'),
                subtitle: Text(department),
              ),
              ListTile(
                title: const Text('Open courses'),
                onTap: () => setState(() => destination = Destination.courses),
              ),
              ListTile(
                title: const Text('Open product examples'),
                onTap: () => Navigator.push<void>(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductList()),
                ),
              ),
              ListTile(
                title: const Text('Open portal details'),
                onTap: () => Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DetailPage(
                      title: 'Portal details',
                      lines: ['Explore routes through the student portal.'],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Destination.courses => const TabBarView(
            children: [
              CourseList(),
              CourseList(completed: false),
              CourseList(completed: true),
            ],
          ),
          Destination.profile => ListView(
            children: [
              ListTile(title: Text(student), subtitle: Text(department)),
              ListTile(title: const Text('Edit profile'), onTap: editProfile),
              ListTile(
                title: const Text('Select department'),
                onTap: selectDepartment,
              ),
            ],
          ),
          Destination.settings => ListView(
            children: [
              ListTile(
                title: const Text('Department'),
                subtitle: Text(department),
                onTap: selectDepartment,
              ),
              ListTile(
                title: const Text('Sign out'),
                onTap: () => Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (_) => false,
                ),
              ),
            ],
          ),
        },
      ),
    );
  }
}

class Course {
  const Course(this.id, this.name, this.credits, this.completed);
  final String id, name;
  final int credits;
  final bool completed;
}

class CourseList extends StatelessWidget {
  const CourseList({super.key, this.completed});
  final bool? completed;
  static const courses = [
    Course('AMP-01', 'Mobile Programming', 3, false),
    Course('DB-02', 'Databases', 4, true),
    Course('SE-03', 'Software Testing', 3, false),
  ];

  @override
  Widget build(BuildContext context) => ListView(
    children: [
      for (final course in courses)
        if (completed == null || course.completed == completed)
          ListTile(
            title: Text(course.name),
            subtitle: Text(course.id),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (_) => CourseDetailsPage(course: course),
              ),
            ),
          ),
    ],
  );
}

class CourseDetailsPage extends StatelessWidget {
  const CourseDetailsPage({super.key, required this.course});
  final Course course;
  @override
  Widget build(BuildContext context) => DetailPage(
    title: course.name,
    lines: [
      'Course ID: ${course.id}',
      'Credits: ${course.credits}',
      course.completed ? 'Completed' : 'Active',
    ],
  );
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.title, required this.lines});
  final String title;
  final List<String> lines;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final line in lines) ListTile(title: Text(line)),
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back'),
        ),
      ],
    ),
  );
}

class DepartmentPage extends StatelessWidget {
  const DepartmentPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Select department')),
    body: ListView(
      children: [
        for (final department in [
          'Software Engineering',
          'Computer Science',
          'Information Systems',
        ])
          ListTile(
            title: Text(department),
            onTap: () => Navigator.pop(context, department),
          ),
      ],
    ),
  );
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.name});
  final String name;
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String name = widget.name;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Edit profile')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextFormField(
          initialValue: name,
          decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (value) => setState(() => name = value),
        ),
        FilledButton(
          onPressed: name.trim().isEmpty
              ? null
              : () => Navigator.pop(context, name.trim()),
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Product examples')),
    body: ListView(
      children: [
        for (final (id, name, price) in const [
          ('P-01', 'Workbook', 8.50),
          ('P-02', 'Notebook', 4.00),
          ('P-03', 'Pen', 1.50),
        ])
          ListTile(
            title: Text(name),
            onTap: () => Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ProductDetailsPage(id: id, name: name, price: price),
              ),
            ),
          ),
      ],
    ),
  );
}

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.id,
    required this.name,
    required this.price,
  });
  final String id, name;
  final double price;
  @override
  Widget build(BuildContext context) => DetailPage(
    title: name,
    lines: ['Product ID: $id', 'Price: \$${price.toStringAsFixed(2)}'],
  );
}
