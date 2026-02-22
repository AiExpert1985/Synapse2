# Review: Media Import Screen

**Status:** APPROVED

1. Goal Achieved: ✔ — `lib/main.dart` `ImportScreen._importMedia()` picks image/video via `FilePicker.platform.pickFiles(type: FileType.media)`, copies to `getApplicationDocumentsDirectory()`, deletes original, and updates `_sourcePath`/`_destPath` state. Both paths render as `_PathRow` widgets below the button. Errors are appended to `_errors` list (rendered as red `ListView`) and emitted via `debugPrint`.
2. Contracts Preserved: ✔ — C-01: all file operations are local `dart:io` calls, no network. C-03: no cloud dependency; fully offline.
3. Scope Preserved: ✔ — Single file selection only; no Riverpod/Go Router; no preview; no persistent history. Home screen replaced (`home: const ImportScreen()`).

**Files Verified:**
- `pubspec.yaml` — `file_picker: ^10.3.10`, `path: ^1.9.0`, `path_provider: ^2.1.5` added
- `android/app/src/main/AndroidManifest.xml` — `READ_MEDIA_IMAGES`, `READ_MEDIA_VIDEO`, `READ_EXTERNAL_STORAGE` (maxSdkVersion 32) declared
- `lib/main.dart` — `MyHomePage` removed; `ImportScreen` added; `flutter analyze` reports no issues

**Notes:** `path` package added as explicit dependency (mechanical — linter requirement).
