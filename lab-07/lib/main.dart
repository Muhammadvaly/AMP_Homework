import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: GestureLab()));

class GestureLab extends StatefulWidget {
  const GestureLab({super.key});
  @override
  State<GestureLab> createState() => _GestureLabState();
}

class _GestureLabState extends State<GestureLab> {
  final transform = TransformationController();
  bool favorite = false, showInfo = false, deleted = false, blue = false;
  double swipe = 0, zoom = 1, initialZoom = 1;
  Offset position = Offset.zero;

  void toggleFavorite() => setState(() => favorite = !favorite);
  void toggleInfo() => setState(() => showInfo = !showInfo);
  void resetZoom() => transform.value = Matrix4.identity();

  void actions() => showModalBottomSheet<void>(
    context: context,
    builder: (context) => SafeArea(
      child: ListTile(
        leading: const Icon(Icons.restart_alt),
        title: const Text('Reset photo zoom'),
        onTap: () {
          resetZoom();
          Navigator.pop(context);
        },
      ),
    ),
  );

  @override
  void dispose() {
    transform.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Interactive photo viewer')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        GestureDetector(
          onTap: toggleInfo,
          onTapDown: (details) => debugPrint(
            'Local: ${details.localPosition}, global: ${details.globalPosition}',
          ),
          onDoubleTap: toggleFavorite,
          onLongPress: actions,
          onLongPressStart: (details) =>
              debugPrint('Long press at ${details.localPosition}'),
          child: Stack(
            children: [
              SizedBox(
                height: 230,
                width: double.infinity,
                child: InteractiveViewer(
                  transformationController: transform,
                  minScale: 0.5,
                  maxScale: 4,
                  child: Image.asset(
                    'assets/photo.png',
                    fit: BoxFit.cover,
                    semanticLabel: 'Mountain landscape artwork',
                  ),
                ),
              ),
              if (showInfo)
                const Positioned(
                  bottom: 8,
                  left: 8,
                  child: IgnorePointer(
                    child: Chip(label: Text('Mountain landscape')),
                  ),
                ),
            ],
          ),
        ),
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: toggleInfo,
              child: Text(showInfo ? 'Hide info' : 'Show info'),
            ),
            IconButton(
              tooltip: favorite ? 'Remove favorite' : 'Mark favorite',
              onPressed: toggleFavorite,
              icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
            ),
            IconButton(
              tooltip: 'Photo actions',
              onPressed: actions,
              icon: const Icon(Icons.more_horiz),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => setState(() => blue = !blue),
          onDoubleTap: toggleFavorite,
          onTapDown: (details) => debugPrint(
            'Local: ${details.localPosition}, global: ${details.globalPosition}',
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            color: blue ? Colors.lightBlue.shade100 : Colors.amber.shade100,
            child: Text(
              favorite
                  ? 'Favorite selected'
                  : 'Tap for color, double-tap to favorite',
            ),
          ),
        ),
        InkWell(
          onTap: toggleInfo,
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Text('InkWell tap feedback'),
          ),
        ),
        const ListTile(title: Text('Drag the square')),
        LayoutBuilder(
          builder: (context, constraints) {
            final bounds = ((constraints.maxWidth - 48) / 2).clamp(
              0.0,
              double.infinity,
            );
            return Container(
              height: 140,
              color: Colors.blueGrey.shade50,
              alignment: Alignment.center,
              child: Transform.translate(
                offset: position,
                child: GestureDetector(
                  onPanUpdate: (details) => setState(() {
                    final next = position + details.delta;
                    position = Offset(
                      next.dx.clamp(-bounds, bounds).toDouble(),
                      next.dy.clamp(-46, 46).toDouble(),
                    );
                  }),
                  child: const ColoredBox(
                    color: Colors.indigo,
                    child: SizedBox.square(dimension: 48),
                  ),
                ),
              ),
            );
          },
        ),
        TextButton(
          onPressed: () => setState(() => position = Offset.zero),
          child: const Text('Reset square'),
        ),
        if (deleted)
          TextButton(
            onPressed: () => setState(() => deleted = false),
            child: const Text('Undo swipe'),
          )
        else
          GestureDetector(
            onHorizontalDragUpdate: (details) =>
                setState(() => swipe += details.delta.dx),
            onHorizontalDragCancel: () => setState(() => swipe = 0),
            onHorizontalDragEnd: (details) => setState(() {
              deleted =
                  swipe.abs() >= 80 ||
                  (details.primaryVelocity ?? 0).abs() > 550;
              swipe = 0;
            }),
            child: Transform.translate(
              offset: Offset(swipe, 0),
              child: const Card(
                child: ListTile(title: Text('Swipe this card to remove it')),
              ),
            ),
          ),
        ListTile(
          title: Text('Custom pinch zoom: ${zoom.toStringAsFixed(1)}×'),
          trailing: TextButton(
            onPressed: () => setState(() => zoom = 1),
            child: const Text('Reset'),
          ),
        ),
        ClipRect(
          child: GestureDetector(
            onScaleStart: (_) => initialZoom = zoom,
            onScaleUpdate: (details) => setState(
              () => zoom = (initialZoom * details.scale)
                  .clamp(0.5, 4.0)
                  .toDouble(),
            ),
            child: Transform.scale(
              scale: zoom,
              child: Image.asset('assets/photo.png', height: 100),
            ),
          ),
        ),
      ],
    ),
  );
}
