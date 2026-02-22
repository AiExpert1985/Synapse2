# Plan: Media Import Screen

## Goal
Replace the default home screen with a simple import screen that picks, moves, and logs media files.

## Scope Boundaries
✓ In scope: file picker, file move, delete original, path display, on-screen + console error log
✗ Out of scope: Riverpod, Go Router, file preview, multi-select, persistent history

---

## Relevant Contracts

- **C-01 — Data Sovereignty** — All file operations are local-only; no network calls involved.
- **C-03 — Capture Availability** — Feature is fully offline; no cloud dependency.

---

## Relevant Design Constraints

- **Android-first** — Android permissions (`READ_MEDIA_IMAGES`, `READ_MEDIA_VIDEO`, or legacy `READ_EXTERNAL_STORAGE`) must be declared in `AndroidManifest.xml`. `file_picker` handles the runtime permission dialog internally.
- **Simple StatefulWidget** — No Riverpod or Go Router; plain `setState` only.

---

## Execution Strategy

Add `file_picker` and `path_provider` to `pubspec.yaml`. Add required Android permissions to `AndroidManifest.xml`. Replace `MyHomePage` in `main.dart` with an `ImportScreen` StatefulWidget that holds state for source path, destination path, and a list of error strings. The import button calls `FilePicker.platform.pickFiles(type: FileType.media)`, then copies the file to `getApplicationDocumentsDirectory()` using `dart:io`, deletes the original, and updates state. Errors from either operation are appended to the error list and printed via `debugPrint`. The UI renders both paths as `Text` widgets below the button and the error log as a scrollable `ListView`.

---

## Affected Files

- `pubspec.yaml` — Add `file_picker: ^10.3.10`, `path_provider: ^2.1.5`
- `android/app/src/main/AndroidManifest.xml` — Add `READ_MEDIA_IMAGES`, `READ_MEDIA_VIDEO`, `READ_EXTERNAL_STORAGE` permissions
- `lib/main.dart` — Replace `MyHomePage` with `ImportScreen`; no contract impact
