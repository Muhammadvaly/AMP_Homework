# Lecture 09 — Styling and light/dark themes

From this directory, run:

```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

For Android, generate the native runner with `flutter create --platforms=android --org com.amplabs .` from this directory. Then use `flutter devices` and `flutter run -d DEVICE_ID`.

Switch device appearance to see system light and dark themes. Compare the gradient header with the restrained cards. The image, overlay, and favorite badge are layered with Stack and Positioned. DejaVu Sans regular and bold files are registered as Course Sans; the bundled copyright file covers redistribution. Open profile details and use Back to return.
