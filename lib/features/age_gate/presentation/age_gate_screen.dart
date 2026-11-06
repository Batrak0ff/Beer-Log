import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';

class AgeGateScreen extends StatelessWidget {
  const AgeGateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Возраст')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BrewLog — дневник дегустаций для совершеннолетних',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: appSettingsStore.confirmAge,
                child: const Text('Мне 18+'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.push('/privacy'),
                child: const Text('Политика конфиденциальности'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
