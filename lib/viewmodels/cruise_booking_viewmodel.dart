
import 'package:flutter/material.dart';

import '../models/cruise_destination.dart';

class CruiseBookingViewModel extends ChangeNotifier {
  // Destination information from the Model.
  final CruiseDestination destination =
      CruiseDestination.rajangRiver;

  // Dynamic star rating.
  late int _starCount;
  bool _isStarred = false;

  // Booking preferences.
  DateTime? _selectedDate;
  String _selectedPackage = 'Private River Cruise';

  // Theme preference.
  bool _isDarkMode = false;

  CruiseBookingViewModel() {
    _starCount = destination.initialRating;
  }

  // Getters allow the View to read current values.
  int get starCount => _starCount;

  bool get isStarred => _isStarred;

  DateTime? get selectedDate => _selectedDate;

  String get selectedPackage => _selectedPackage;

  bool get isDarkMode => _isDarkMode;

  List<String> get availablePackages =>
      CruiseDestination.cruisePackages;

  ThemeMode get themeMode =>
      _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Toggle the star rating.
  void toggleStar() {
    if (_isStarred) {
      _starCount--;
      _isStarred = false;
    } else {
      _starCount++;
      _isStarred = true;
    }

    notifyListeners();
  }

  // Update the selected cruise date.
  void setSelectedDate(DateTime date) {
    _selectedDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    notifyListeners();
  }

  // Update the selected cruise package.
  void setSelectedPackage(String package) {
    if (!availablePackages.contains(package)) {
      return;
    }

    _selectedPackage = package;
    notifyListeners();
  }

  // Enable or disable dark mode.
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  // Toggle between light and dark modes.
  void toggleDarkMode() {
    setDarkMode(!_isDarkMode);
  }

  // Return a readable date for the UI.
  String get formattedDate {
    if (_selectedDate == null) {
      return 'Select a date';
    }

    final date = _selectedDate!;

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }
}
