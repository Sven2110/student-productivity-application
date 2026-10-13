import 'package:flutter/foundation.dart';

/// Holds which bottom-nav tab is currently active in MainShellScreen.
/// Lifted out of MainShellScreen's local State so that other widgets
/// (like a card on the Dashboard) can switch tabs programmatically —
/// e.g. tapping "Timetable" on the Dashboard should switch the bottom
/// nav to the Timetable tab, not push a second Timetable screen on top.
class NavigationProvider extends ChangeNotifier {
  int _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;

  void setTab(int index) {
    if (_currentTabIndex == index) return;
    _currentTabIndex = index;
    notifyListeners();
  }
}