import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:som_portfolio/core/widgets/glass_card.dart';
import '../../../../data/portfolio_data.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SKILL ENGINE",
              style: TextStyle(
                color: Colors.blue,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: PortfolioData.skills.length,
              gridDelegate:
              const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 350,
                mainAxisExtent: 140,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                final skill = PortfolioData.skills[index];

                return GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        skill.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: skill.proficiency,
                        backgroundColor:
                        Colors.grey.withValues(alpha: 0.2),
                        valueColor:
                        const AlwaysStoppedAnimation<Color>(
                          Colors.blue,
                        ),
                      ),
                    ],
                  ),
                )
                    .animate(delay: (index * 100).ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.2, end: 0);
              },
            ),
          ],
        ),
      ),
    );
  }
}