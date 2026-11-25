# Lecture 01 — Environment setup and widget lifecycle

From this directory, run:

```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

For Android, generate the native runner with `flutter create --platforms=android --org com.amplabs .` from this directory. Then use `flutter devices` and `flutter run -d DEVICE_ID`.

Run `flutter --version`, `flutter doctor`, and `flutter devices`. On Windows, install Android Studio and its SDK, accept required Android SDK licenses with `flutter doctor --android-licenses`, and start an emulator or connect an Android device with USB debugging enabled.

Widget tree (omits framework internals): `MaterialApp → LifecycleHome → Scaffold → Center → Column` with `Text` and a navigation button under the Column. LifecycleHome is stateless. Widget objects are immutable configurations. An Element represents a mounted location and retains the corresponding State instance for a stateful widget.

Open **Observe the lifecycle**, increment the counter, then go Back. Watch the console for `initState`, repeated `build`, and `dispose`. The changing count lives in the mutable State object.
