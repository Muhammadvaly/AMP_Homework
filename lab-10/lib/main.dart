import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: OnboardingPage()));

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late final sequence = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 950),
  );
  late final rotation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  late final demoScale = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );
  late final logo = Tween<double>(begin: 0.75, end: 1)
      .chain(
        CurveTween(curve: const Interval(0, 0.35, curve: Curves.easeOutBack)),
      )
      .animate(sequence);
  late final title = sequence.drive(
    CurveTween(curve: const Interval(0.16, 0.55, curve: Curves.easeOut)),
  );
  late final description =
      Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
          .chain(
            CurveTween(
              curve: const Interval(0.35, 0.76, curve: Curves.easeOutCubic),
            ),
          )
          .animate(sequence);
  late final button = sequence.drive(
    CurveTween(curve: const Interval(0.72, 1)),
  );
  late final scaleCurve = CurvedAnimation(
    parent: demoScale,
    curve: Curves.easeInOut,
  );
  late final scale = Tween<double>(begin: 0.8, end: 1.2).animate(scaleCurve);
  bool large = false, visible = true, unlocked = false, started = false;

  Duration get implicitDuration => MediaQuery.disableAnimationsOf(context)
      ? Duration.zero
      : const Duration(milliseconds: 400);

  void play() {
    if (MediaQuery.disableAnimationsOf(context)) {
      sequence.value = 1;
    } else {
      sequence.forward(from: 0);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!started) {
      started = true;
      play();
    }
  }

  @override
  void dispose() {
    sequence.dispose();
    rotation.dispose();
    scaleCurve.dispose();
    demoScale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Flutter animation lab')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ScaleTransition(
                  scale: logo,
                  child: const Icon(Icons.flutter_dash, size: 64),
                ),
                FadeTransition(
                  opacity: title,
                  child: Text(
                    'Welcome to Flutter',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 8),
                SlideTransition(
                  position: description,
                  child: const Text(
                    'Explore animation with a short onboarding sequence.',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                FadeTransition(
                  opacity: button,
                  child: AnimatedBuilder(
                    animation: sequence,
                    builder: (context, _) => FilledButton(
                      onPressed: sequence.isCompleted
                          ? () => Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Scaffold(
                                  appBar: AppBar(
                                    title: const Text('Ready to start'),
                                  ),
                                  body: const Center(
                                    child: Text('Onboarding complete'),
                                  ),
                                ),
                              ),
                            )
                          : null,
                      child: const Text('Continue'),
                    ),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    TextButton(onPressed: play, child: const Text('Replay')),
                    TextButton(
                      onPressed: () {
                        if (MediaQuery.disableAnimationsOf(context)) {
                          sequence.value = 0;
                        } else {
                          sequence.reverse();
                        }
                      },
                      child: const Text('Reverse'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Implicit animations'),
        Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: implicitDuration,
            curve: Curves.easeInOut,
            width: large ? 130 : 62,
            height: large ? 84 : 62,
            decoration: BoxDecoration(
              color: large ? Colors.teal : Colors.indigo,
              borderRadius: BorderRadius.circular(large ? 28 : 6),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: implicitDuration,
          opacity: visible ? 1 : 0,
          child: ExcludeSemantics(
            excluding: !visible,
            child: const ListTile(title: Text('Profile information')),
          ),
        ),
        AnimatedCrossFade(
          duration: implicitDuration,
          crossFadeState: unlocked
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: const Text('Locked'),
          secondChild: const Text('Unlocked'),
        ),
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: () => setState(() => large = !large),
              child: const Text('Resize'),
            ),
            TextButton(
              onPressed: () => setState(() => visible = !visible),
              child: const Text('Toggle profile'),
            ),
            TextButton(
              onPressed: () => setState(() => unlocked = !unlocked),
              child: const Text('Toggle lock'),
            ),
          ],
        ),
        const Text('Explicit animations'),
        ScaleTransition(
          scale: scale,
          child: const Icon(Icons.star, color: Colors.amber),
        ),
        TextButton(
          onPressed: () {
            if (MediaQuery.disableAnimationsOf(context)) {
              demoScale.value = 1;
            } else {
              demoScale.forward(from: 0);
            }
          },
          child: const Text('Scale star'),
        ),
        AnimatedBuilder(
          animation: rotation,
          child: const Icon(Icons.refresh, size: 36),
          builder: (_, child) => Transform.rotate(
            angle: rotation.value * 6.283185307179586,
            child: child,
          ),
        ),
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: rotation.forward,
              child: const Text('Forward spin'),
            ),
            TextButton(
              onPressed: rotation.reverse,
              child: const Text('Reverse spin'),
            ),
            TextButton(
              onPressed: MediaQuery.disableAnimationsOf(context)
                  ? null
                  : () => rotation.repeat(),
              child: const Text('Repeat spin'),
            ),
            TextButton(
              onPressed: rotation.stop,
              child: const Text('Stop spin'),
            ),
          ],
        ),
      ],
    ),
  );
}
