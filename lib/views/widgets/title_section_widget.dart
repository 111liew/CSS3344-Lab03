
import 'package:flutter/material.dart';

import '../../viewmodels/cruise_booking_viewmodel.dart';

class TitleSectionWidget extends StatelessWidget {
  final CruiseBookingViewModel viewModel;

  const TitleSectionWidget({
    super.key,
    required this.viewModel,
  });

  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textColor =
    isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A);

    final subtitleColor =
    isDark ? const Color(0xFFBAC5D4) : const Color(0xFF64748B);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.destination.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 23,
                    height: 1.25,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 17,
                      color: gold,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        viewModel.destination.location,
                        style: TextStyle(
                          fontSize: 13,
                          color: subtitleColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: isDark
                ? const Color(0xFF30291C)
                : const Color(0xFFFFF6DF),
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: viewModel.toggleStar,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      viewModel.isStarred
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: gold,
                      size: 23,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${viewModel.starCount}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
