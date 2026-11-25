# Lecture 10 — Animation and onboarding

From this directory, run:

```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

For Android, connect a device or start an emulator, then run flutter devices and flutter run -d DEVICE_ID.

The 950 ms onboarding sequence scales the logo during 0–35%, fades the title during 16–55%, slides the description during 35–76%, and fades Continue during 72–100%. Replay and Reverse drive the same controller. Additional demos show AnimatedContainer, AnimatedOpacity, AnimatedCrossFade, ScaleTransition and a repeating AnimatedBuilder rotation with a stop control. Change the implicit duration to compare how quickly the interface responds.
