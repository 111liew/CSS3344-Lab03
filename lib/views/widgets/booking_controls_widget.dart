
import 'package:flutter/material.dart';

import '../../viewmodels/cruise_booking_viewmodel.dart';

class BookingControlsWidget extends StatelessWidget {
  final CruiseBookingViewModel viewModel;

  const BookingControlsWidget({
    super.key,
    required this.viewModel,
  });

  static const Color gold = Color(0xFFD4AF37);

  Future<void> _selectDate(BuildContext context) async {
    final today = DateUtils.dateOnly(DateTime.now());

    final initialDate = viewModel.selectedDate != null &&
        !viewModel.selectedDate!.isBefore(today)
        ? viewModel.selectedDate!
        : today;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: today,
      lastDate: DateTime(today.year + 5, 12, 31),
      helpText: 'SELECT CRUISE DATE',
      confirmText: 'CONFIRM',
      cancelText: 'CANCEL',
    );

    if (picked != null) {
      viewModel.setSelectedDate(picked);
    }
  }

  InputDecoration _inputDecoration(
      BuildContext context, {
        required IconData icon,
      }) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final borderColor = isDark
        ? const Color(0xFF455368)
        : const Color(0xFFD6DDE8);

    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: gold,
        size: 22,
      ),
      filled: true,
      fillColor: isDark
          ? const Color(0xFF152235)
          : Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: gold,
          width: 1.8,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final panelColor = isDark
        ? const Color(0xFF192536)
        : const Color(0xFFF8FAFC);

    final textColor = isDark
        ? const Color(0xFFF8FAFC)
        : const Color(0xFF14243D);

    final secondaryColor = isDark
        ? const Color(0xFFB6C3D3)
        : const Color(0xFF64748B);

    final dividerColor = isDark
        ? const Color(0xFF3B4A5D)
        : const Color(0xFFE2E8F0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: panelColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.tune_rounded,
                  color: gold,
                  size: 23,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Trip Preferences',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            Text(
              'Visit Date',
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 9),

            InkWell(
              onTap: () => _selectDate(context),
              borderRadius: BorderRadius.circular(14),
              child: InputDecorator(
                decoration: _inputDecoration(
                  context,
                  icon: Icons.calendar_month_outlined,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        viewModel.formattedDate,
                        style: TextStyle(
                          color: viewModel.selectedDate == null
                              ? secondaryColor
                              : textColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: secondaryColor,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            Text(
              'Cruise Package',
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 9),

            DropdownButtonFormField<String>(
              key: ValueKey(viewModel.selectedPackage),
              initialValue: viewModel.selectedPackage,
              isExpanded: true,
              dropdownColor: isDark
                  ? const Color(0xFF243248)
                  : Colors.white,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: secondaryColor,
              ),
              decoration: _inputDecoration(
                context,
                icon: Icons.directions_boat_outlined,
              ),
              items: viewModel.availablePackages.map((package) {
                return DropdownMenuItem<String>(
                  value: package,
                  child: Text(
                    package,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  viewModel.setSelectedPackage(value);
                }
              },
            ),

            const SizedBox(height: 20),

            Divider(color: dividerColor),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: Icon(
                viewModel.isDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: gold,
              ),
              title: Text(
                'Dark Mode',
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                viewModel.isDarkMode
                    ? 'Dark theme enabled'
                    : 'Light theme enabled',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                ),
              ),
              value: viewModel.isDarkMode,
              activeThumbColor: gold,
              onChanged: viewModel.setDarkMode,
            ),

            Divider(color: dividerColor),

            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(
                  Icons.confirmation_number_outlined,
                  color: gold,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your Selection',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            _summaryRow(
              'Date',
              viewModel.formattedDate,
              textColor,
              secondaryColor,
            ),

            const SizedBox(height: 10),

            _summaryRow(
              'Package',
              viewModel.selectedPackage,
              textColor,
              secondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(
      String label,
      String value,
      Color textColor,
      Color secondaryColor,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 65,
          child: Text(
            '$label:',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
