# Lecture 02 — Hello World, theming, and packages

From this directory, run:

```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

For Android, connect a device or start an emulator, then run flutter devices and flutter run -d DEVICE_ID.

The widget tree starts with `CourseApp → MaterialApp → WelcomePage → Scaffold`. The body contains a centered scrolling Column, course information, a counter button, and a locally themed reset button.

Increment the counter, edit the title style, and press `r` during `flutter run` for Hot Reload. The counter should persist. Press `R` for Hot Restart, which creates new Dart state. A full restart stops and relaunches the app and is needed for native configuration changes.

The global theme defines seed colors, type, and elevated button spacing. The reset section overrides the elevated button colors. The platform-independent `intl` package formats the current date.
