import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              color: Color(0xFFFFE8CD),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome_motion_rounded,
              size: 80,
              color: Color(0xFFFFD6BA),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Clear space, clear mind",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D4037),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Your notes will appear here",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF8D6E63),
            ),
          ),
        ],
      ),
    );
  }
}
