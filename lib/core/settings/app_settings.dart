import 'package:flutter/foundation.dart';

@immutable
class AppSettings {
  const AppSettings({required this.ageConfirmed});

  final bool ageConfirmed;

  AppSettings copyWith({bool? ageConfirmed}) {
    return AppSettings(ageConfirmed: ageConfirmed ?? this.ageConfirmed);
  }
}

/// In-memory holder for scaffold routing. Persistence comes in a later slice.
class AppSettingsStore extends ChangeNotifier {
  AppSettings _settings = const AppSettings(ageConfirmed: false);

  AppSettings get settings => _settings;

  bool get ageConfirmed => _settings.ageConfirmed;

  void confirmAge() {
    if (_settings.ageConfirmed) {
      return;
    }
    _settings = _settings.copyWith(ageConfirmed: true);
    notifyListeners();
  }

  void resetForTest() {
    _settings = const AppSettings(ageConfirmed: false);
    notifyListeners();
  }
}

final AppSettingsStore appSettingsStore = AppSettingsStore();
