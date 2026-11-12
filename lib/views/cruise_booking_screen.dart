import 'package:flutter/material.dart';

import '../viewmodels/cruise_booking_viewmodel.dart';
import 'widgets/action_bar_widget.dart';
import 'widgets/booking_controls_widget.dart';
import 'widgets/description_widget.dart';
import 'widgets/header_image_widget.dart';
import 'widgets/title_section_widget.dart';

class CruiseBookingScreen extends StatelessWidget {
  final CruiseBookingViewModel viewModel;

  const CruiseBookingScreen({
    super.key,
    required this.viewModel,
  });

  List<Widget> _buildDetailWidgets(BuildContext context) {
    return [
      Transform.translate(
        offset: const Offset(0, -28),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              TitleSectionWidget(viewModel: viewModel),
              ActionBarWidget(destination: viewModel.destination),
              DescriptionWidget(
                description: viewModel.destination.description,
              ),
              BookingControlsWidget(viewModel: viewModel),
            ],
          ),
        ),
      ),
    ];
  }

  Widget _buildPortrait(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        HeaderImageWidget(
          imagePath: viewModel.destination.imagePath,
          height: 300,
        ),
        ..._buildDetailWidgets(context),
      ],
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: HeaderImageWidget(
            imagePath: viewModel.destination.imagePath,
            height: double.infinity,
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TitleSectionWidget(viewModel: viewModel),
                      ActionBarWidget(destination: viewModel.destination),
                      DescriptionWidget(
                        description: viewModel.destination.description,
                      ),
                      BookingControlsWidget(viewModel: viewModel),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sibu River Cruise & Heritage',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Cruise Information',
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Rajang River Cruise',
                applicationVersion: '1.0',
                applicationLegalese:
                'CSS3344 Mobile Application Development',
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              return _buildLandscape(context);
            }
            return _buildPortrait(context);
          },
        ),
      ),
    );
  }
}