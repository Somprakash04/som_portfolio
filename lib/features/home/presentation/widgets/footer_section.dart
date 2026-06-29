import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/portfolio_data.dart';

class FooterSection extends ConsumerWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final count = ref.watch(visitorCountProvider);
    const count = 1000;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "© 2026 ${PortfolioData.fullName}. Built with Clean Flutter Web.",
              ),
              // Chip(
              //   avatar: const Icon(
              //     Icons.remove_red_eye,
              //     size: 16,
              //   ),
              //   label: Text(
              //     "Telemetry Counter: $count Engine Node Hits",
              //   ),
              // ),
              Chip(
                avatar: const Icon(
                  Icons.remove_red_eye,
                  size: 16,
                ),
                label: Text(
                  "Visitors: $count",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}