import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 100,
            color: const Color(0xFF948979).withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          const Text(
            "No Notes Yet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFDFD0B8),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Tap the + button to add your first note",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF948979),
            ),
          ),
        ],
      ),
    );
  }
}
