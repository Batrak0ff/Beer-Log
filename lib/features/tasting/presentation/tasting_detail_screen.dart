import 'package:flutter/material.dart';

/// Stub: tasting detail (next slice).
class TastingDetailScreen extends StatelessWidget {
  const TastingDetailScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Запись')),
      body: Center(
        child: Text('TODO: запись $id'),
      ),
    );
  }
}
