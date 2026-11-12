
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/cruise_destination.dart';

class ActionBarWidget extends StatelessWidget {
  final CruiseDestination destination;

  const ActionBarWidget({
    super.key,
    required this.destination,
  });

  static const Color gold = Color(0xFFD4AF37);

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showCallDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Contact Information'),
          content: const Text(
            'A verified cruise operator phone number has '
                'not been provided for this lab demo.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openRoute(BuildContext context) async {
    final url = Uri.https(
      'www.google.com',
      '/maps/search/',
      {
        'api': '1',
        'query': 'Sibu Waterfront Sarawak Malaysia',
      },
    );

    try {
      final success = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!success && context.mounted) {
        _showMessage(context, 'Unable to open the map.');
      }
    } catch (_) {
      if (context.mounted) {
        _showMessage(
          context,
          'No map or browser application available.',
        );
      }
    }
  }

  Future<void> _shareDestination(
      BuildContext context,
      ) async {
    final text =
        '${destination.name}\n'
        '${destination.location}\n'
        '${destination.description}';

    await Clipboard.setData(
      ClipboardData(text: text),
    );

    if (context.mounted) {
      _showMessage(
        context,
        'Destination details copied to clipboard!',
      );
    }
  }

  Widget _buildActionItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final background = isDark
        ? const Color(0xFF1C293B)
        : const Color(0xFFF6F8FC);

    final borderColor = isDark
        ? const Color(0xFF38475B)
        : const Color(0xFFE3E8F0);

    final textColor = isDark
        ? const Color(0xFFF8FAFC)
        : const Color(0xFF142A45);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: background,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: gold,
                    size: 25,
                  ),
                  const SizedBox(height: 9),
                  Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Column(
        children: [
          Divider(
            color: isDark
                ? const Color(0xFF344154)
                : const Color(0xFFE2E8F0),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionItem(
                context: context,
                icon: Icons.call_outlined,
                label: 'CALL',
                onTap: () => _showCallDialog(context),
              ),
              _buildActionItem(
                context: context,
                icon: Icons.route_outlined,
                label: 'ROUTE',
                onTap: () => _openRoute(context),
              ),
              _buildActionItem(
                context: context,
                icon: Icons.share_outlined,
                label: 'SHARE',
                onTap: () => _shareDestination(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
