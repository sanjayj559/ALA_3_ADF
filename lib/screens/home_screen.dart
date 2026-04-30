import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/database_service.dart';
import '../widgets/note_card.dart';
import '../widgets/empty_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    setState(() {
      _notes = _dbService.getNotes();
      // Sort notes by date (newest first)
      _notes.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    });
  }

  void _showNoteDialog({Note? note}) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF393E46),
        title: Text(
          note == null ? 'Add Note' : 'Edit Note',
          style: const TextStyle(color: Color(0xFFDFD0B8)),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFF948979)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                style: const TextStyle(color: Colors.white),
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Content',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFF948979)),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF948979),
              foregroundColor: const Color(0xFF222831),
            ),
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                if (note == null) {
                  final newNote = Note(
                    title: titleController.text,
                    content: contentController.text,
                    dateTime: DateTime.now(),
                  );
                  await _dbService.addNote(newNote);
                } else {
                  note.title = titleController.text;
                  note.content = contentController.text;
                  note.dateTime = DateTime.now();
                  await _dbService.updateNote(note);
                }
                _loadNotes();
                if (mounted) Navigator.pop(context);
              }
            },
            child: Text(note == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF393E46),
        title: const Text('Delete Note?', style: TextStyle(color: Color(0xFFDFD0B8))),
        content: const Text('Are you sure you want to delete this note?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              await _dbService.deleteNote(id);
              _loadNotes();
              if (mounted) Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831), // Dark Gray
      appBar: AppBar(
        title: const Text(
          'Smart Student Notes',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFDFD0B8)),
        ),
        backgroundColor: const Color(0xFF393E46),
        elevation: 0,
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _notes.isEmpty
            ? const EmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    curve: Curves.easeInOut,
                    child: NoteCard(
                      note: note,
                      onTap: () => _showNoteDialog(note: note),
                      onDelete: () => _confirmDelete(note.id!),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF948979),
        onPressed: () => _showNoteDialog(),
        child: const Icon(Icons.add, color: Color(0xFF222831), size: 30),
      ),
    );
  }
}
