# Lecture 06 — Buttons, assets, and validated forms

From this directory, run:

```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

For Android, connect a device or start an emulator, then run flutter devices and flutter run -d DEVICE_ID.

Try blank or invalid fields, a valid registration, the department menu, and Reset. Compare portrait and landscape layouts. The primary Submit action is visually prominent and passes validation before displaying a summary. The bundled logo works offline. The network image may show its fallback. AssetBundle reads asynchronously because resource access can involve I/O. rootBundle is global, while DefaultAssetBundle.of(context) supports subtree substitution.
