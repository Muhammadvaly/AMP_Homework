# Lecture 07 — Gestures and photo viewer

From this directory, run:

```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

For Android, generate the native runner with `flutter create --platforms=android --org com.amplabs .` from this directory. Then use `flutter devices` and `flutter run -d DEVICE_ID`.

Tap the photo for information, double-tap for favorite state, and long-press for actions. The visible buttons provide equivalent access and InkWell adds Material feedback. Pinch and pan the main image, then compare the separate custom scale demo. Drag the square and reset it. Swipe the card horizontally and undo its removal. The swipe check uses both displacement and velocity.
