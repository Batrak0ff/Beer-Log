import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brewlog/app/app.dart';
import 'package:brewlog/core/settings/app_settings.dart';

void main() {
  setUp(appSettingsStore.resetForTest);

  testWidgets('app starts on age gate', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: BrewLogApp()));
    await tester.pumpAndSettle();

    expect(find.text('Мне 18+'), findsOneWidget);
    expect(find.text('TODO: Дневник'), findsNothing);
  });
}
