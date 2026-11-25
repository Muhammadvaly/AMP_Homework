# Lecture 03 — Dart basics and student results

From this directory, run:

```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

For Android, generate the native runner with `flutter create --platforms=android --org com.amplabs .` from this directory. Then use `flutter devices` and `flutter run -d DEVICE_ID`.

Run `dart run lib/student_result_analyzer.dart` for variables, arithmetic, logical comparisons, loops, list mutations, constructors, and grade calculations. The sample uses 50 as the pass threshold. Inferred variables include a String name and an int age. The Flutter screen uses final fields, String interpolation, a topic list, and conditional display.
