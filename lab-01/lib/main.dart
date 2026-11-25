import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LifecycleHome()));

class LifecycleHome extends StatelessWidget {
  const LifecycleHome({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Flutter setup and lifecycle')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Hello, Flutter!'),
          FilledButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const CounterPage()),
            ),
            child: const Text('Observe the lifecycle'),
          ),
        ],
      ),
    ),
  );
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;
  @override
  void initState() {
    super.initState();
    debugPrint('Counter.initState');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Counter.build: $count');
    return Scaffold(
      appBar: AppBar(title: const Text('Lifecycle counter')),
      body: Center(child: Text('Count: $count')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increase count',
        onPressed: () => setState(() => count++),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    debugPrint('Counter.dispose');
    super.dispose();
  }
}
