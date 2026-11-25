# Lecture 05 — Common widgets and responsive profile

From this directory, run:

```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

For Android, connect a device or start an emulator, then run flutter devices and flutter run -d DEVICE_ID.

Open at phone and tablet widths. Padding is inside a Container, and margin is exterior space. Row's main axis is horizontal, and Column's main axis is vertical. Change the alignment to see how space distribution changes. To reproduce a Row overflow locally, temporarily remove Expanded from the long email, then restore it. SingleChildScrollView enables vertical scrolling for the longer content.
