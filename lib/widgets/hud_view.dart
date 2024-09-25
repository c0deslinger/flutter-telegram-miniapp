import 'package:flutter/material.dart';

class HudView extends StatelessWidget {
  const HudView({super.key, required this.label, required this.icon});

  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            icon,
            const SizedBox(height: 8),
            Text(label,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
