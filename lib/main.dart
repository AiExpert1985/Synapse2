import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Synapse',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const ImportScreen(),
    );
  }
}

class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  String? _sourcePath;
  String? _destPath;
  final List<String> _errors = [];
  bool _isLoading = false;

  Future<void> _importMedia() async {
    setState(() {
      _sourcePath = null;
      _destPath = null;
      _errors.clear();
      _isLoading = true;
    });

    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.media);
      if (result == null || result.files.single.path == null) {
        setState(() => _isLoading = false);
        return;
      }

      final sourcePath = result.files.single.path!;
      final fileName = result.files.single.name;
      final appDir = await getApplicationDocumentsDirectory();
      final destPath = p.join(appDir.path, fileName);

      await _moveFile(sourcePath, destPath);
    } catch (e) {
      _logError('Unexpected error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _moveFile(String sourcePath, String destPath) async {
    File? copiedFile;
    try {
      copiedFile = await File(sourcePath).copy(destPath);
    } catch (e) {
      _logError('Move failed (copy step): $e');
      return;
    }

    try {
      await File(sourcePath).delete();
    } catch (e) {
      _logError('Delete original failed: $e');
      // Copy succeeded but delete failed — still show destination.
    }

    setState(() {
      _sourcePath = sourcePath;
      _destPath = copiedFile!.path;
    });
  }

  void _logError(String message) {
    debugPrint('[ImportScreen] $message');
    setState(() => _errors.add(message));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import Media')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _importMedia,
              icon: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.upload_file),
              label: Text(_isLoading ? 'Importing…' : 'Import Image / Video'),
            ),
            const SizedBox(height: 20),
            if (_sourcePath != null) ...[
              _PathRow(label: 'Source', path: _sourcePath!),
              const SizedBox(height: 8),
              _PathRow(label: 'Destination', path: _destPath!),
            ],
            if (_errors.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text('Errors:', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Expanded(
                child: ListView.builder(
                  itemCount: _errors.length,
                  itemBuilder: (context, index) => Text(
                    '• ${_errors[index]}',
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PathRow extends StatelessWidget {
  const _PathRow({required this.label, required this.path});

  final String label;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 2),
        Text(path, style: const TextStyle(fontSize: 12, color: Colors.black87)),
      ],
    );
  }
}
