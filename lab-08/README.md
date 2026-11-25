# Lecture 08 — Navigation and student portal

From this directory, run:

```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

For Android, connect a device or start an emulator, then run flutter devices and flutter run -d DEVICE_ID.

Route map: Login → Dashboard (replacement); Drawer → Dashboard / Courses / Profile / Settings; Courses → Course Details; Profile → Edit Profile → returned name; Profile or Settings → Department Selector → returned department. Back from a details page returns to its caller. Tabs change the active course category without pushing a new route. Login is a local navigation exercise.
