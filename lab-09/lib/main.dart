import 'package:flutter/material.dart';

void main() => runApp(const StyleApp());

const brand = Color(0xff365b71);

ThemeData dashboardTheme(Brightness brightness) {
  final colors = ColorScheme.fromSeed(seedColor: brand, brightness: brightness);
  return ThemeData(
    colorScheme: colors,
    fontFamily: 'Course Sans',
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontWeight: FontWeight.w700),
    ),
    cardTheme: CardThemeData(
      color: colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: colors.outlineVariant),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primaryContainer,
        foregroundColor: colors.onPrimaryContainer,
      ),
    ),
  );
}

class StyleApp extends StatelessWidget {
  const StyleApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: dashboardTheme(Brightness.light),
    darkTheme: dashboardTheme(Brightness.dark),
    themeMode: ThemeMode.system,
    home: const Dashboard(),
  );
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [Color(0xff234255), Color(0xff386357)],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset('assets/banner.png', fit: BoxFit.cover),
                ),
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xF0213541), Color(0xA82D4F56)],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 64, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/banner.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Advanced Mobile Programming Portfolio',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Amina Rahimi • Semester 7',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Badge(
                    isLabelVisible: favorite,
                    child: IconButton(
                      tooltip: favorite
                          ? 'Remove favorite'
                          : 'Favorite profile',
                      color: Colors.white,
                      onPressed: () => setState(() => favorite = !favorite),
                      icon: Icon(
                        favorite ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (final (icon, title, details) in const [
            (Icons.school_outlined, 'Department', 'Software Engineering'),
            (
              Icons.menu_book_outlined,
              'Current module',
              'Widget styling and design',
            ),
            (
              Icons.dark_mode_outlined,
              'Appearance',
              'Follows your device theme',
            ),
          ])
            Card(
              child: ListTile(
                leading: Icon(icon),
                title: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Course Sans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(details, style: theme.textTheme.bodyMedium),
              ),
            ),
          const SizedBox(height: 12),
          Text('Decoration examples', style: theme.textTheme.titleMedium),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final (label, decoration) in [
                (
                  'Border',
                  BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                (
                  'Photo',
                  const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                (
                  'Shadow',
                  BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 6,
                        offset: Offset(1, 3),
                      ),
                    ],
                  ),
                ),
                (
                  'Gradient',
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primaryContainer,
                        theme.colorScheme.secondaryContainer,
                      ],
                    ),
                  ),
                ),
              ])
                Column(
                  children: [
                    Container(width: 56, height: 56, decoration: decoration),
                    const SizedBox(height: 4),
                    Text(label),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.push<void>(
              context,
              MaterialPageRoute(builder: (_) => const ProfileDetails()),
            ),
            child: const Text('Open profile details'),
          ),
        ],
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Profile details')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Amina Rahimi', style: Theme.of(context).textTheme.headlineSmall),
        const Text('Software Engineering • Advanced Mobile Programming'),
      ],
    ),
  );
}
