# Task: Media Import Screen

## Goal
Replace the default home screen with an import screen that lets the user pick an image or video, moves it to the app's documents directory, deletes the original, and displays both paths and any errors on-screen.

## Scope
✓ Included:
- Replace current `MyHomePage` with a new `ImportScreen` widget
- Button to trigger file picker (image and video only)
- Move picked file to `getApplicationDocumentsDirectory()`
- Delete the original file after successful move
- Display source path below the import button
- Display destination path below the source path
- On-screen scrollable error log for move/delete failures
- `debugPrint` of any errors to the debug console

✗ Excluded:
- Riverpod, Go Router, or any state management framework
- Multiple file selection
- File preview (thumbnail/video player)
- Persistent storage of import history
- iOS-specific permissions (Android-first, matching project direction)

## Constraints
- C-01: All data stays on-device — no network calls
- C-03: Must work fully offline
- Keep implementation as simple as possible (StatefulWidget, no frameworks)
- Use `file_picker ^10.3.10` and `path_provider ^2.1.5`

## Open Questions
- None
