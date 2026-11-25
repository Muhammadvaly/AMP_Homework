mixin Logger {
  void log(String message) => print(message);
}

class Student {
  const Student({
    required this.name,
    required this.id,
    required this.semester,
    required this.department,
  });
  Student.fromMap(Map<String, Object> data)
    : this(
        name: data['name'] as String,
        id: data['id'] as String,
        semester: data['semester'] as int,
        department: data['department'] as String,
      );
  final String name;
  final String id;
  final int semester;
  final String department;
}

class Course {
  const Course({required this.title, required this.credits});
  final String title;
  final int credits;
}

class Registration with Logger {
  Registration({required this.student});
  final Student student;
  final metadata = <String, Object>{};
  final _courses = <Course>[];
  List<Course> get courses => List.unmodifiable(_courses);
  int get credits => _courses.fold(0, (sum, course) => sum + course.credits);
  void add(Course course) {
    if (_courses.any((item) => item.title == course.title)) return;
    _courses.add(course);
    log('Registered: ${course.title}');
  }

  void remove(Course course) => _courses.remove(course);
}

class Product {
  const Product({required this.name, this.price = 10});
  const Product.free({required String name}) : this(name: name, price: 0);
  final String name;
  final double price;
}

class BankAccount with Logger {
  double _balance = 0;
  double get balance => _balance;
  void deposit(double amount) {
    if (!amount.isFinite || amount <= 0)
      throw ArgumentError.value(amount, 'amount');
    _balance += amount;
    log('Deposited $amount');
  }
}

class StudentProfile {
  String name = '';
  int semester = 1;
  void show() => print('$name • Semester $semester');
}

int doubleCredits(int value) => value * 2;

List<int> transform(List<int> values, int Function(int) mapper) {
  return values.map(mapper).toList();
}

void main(List<String> arguments) {
  const requiredTopics = ['Widgets', 'State'];
  const optionalTopics = ['Navigation'];
  final List<String>? extraTopics = DateTime.now().weekday == DateTime.friday
      ? ['Review']
      : null;
  final admin = arguments.contains('--admin');
  final menu = [
    ...requiredTopics,
    ...optionalTopics,
    ...?extraTopics,
    if (admin) 'Admin',
  ];
  print([for (final topic in menu) 'Topic: $topic']);

  final data = <String, Object>{
    'name': 'Amina',
    'id': 'S-101',
    'semester': 6,
    'department': 'Software Engineering',
  };
  print(data['name']);
  data['semester'] = 7;
  data['address'] = {'city': 'Kabul'};
  data['temporary'] = true;
  data.remove('temporary');
  for (final entry in data.entries) {
    print('${entry.key} = ${entry.value}');
  }
  final student = Student.fromMap(data);
  final mapper = doubleCredits;
  print(transform([2, 3], mapper));
  print(transform([2, 3], (credits) => credits + 1));

  for (final product in [
    const Product(name: 'Workbook'),
    const Product.free(name: 'Syllabus'),
  ]) {
    print('${product.name}: ${product.price}');
  }
  final account = BankAccount()..deposit(25);
  print('Balance: ${account.balance}');

  final profile = StudentProfile();
  profile.name = student.name;
  profile.semester = student.semester;
  profile.show();
  StudentProfile()
    ..name = student.name
    ..semester = student.semester
    ..show();

  const requiredCourses = [Course(title: 'Flutter', credits: 3)];
  const electives = [Course(title: 'UI design', credits: 2)];
  final registration = Registration(student: student)
    ..metadata['term'] = 'Semester 7'
    ..add(requiredCourses.first);
  for (final course in [...requiredCourses, ...electives]) {
    registration.add(course);
  }
  print('${registration.student.name}: ${registration.credits} credits');
}
