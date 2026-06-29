import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../data/portfolio_data.dart';
import '../../../../providers/projects_provider.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(projectsFilterProvider);

    // Filter logic handling updates instantly from centralized state
    final filteredProjects = PortfolioData.projects.where((project) {
      final matchesSearch =
          project.title.toLowerCase().contains(
            homeState.query.toLowerCase(),
          ) ||
              project.description.toLowerCase().contains(
                homeState.query.toLowerCase(),
              );

      final matchesCategory =
          homeState.category == 'All' ||
              project.category == homeState.category;

      return matchesSearch && matchesCategory;
    }).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      width: 1200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PROJECT COMPOSITIONS",
            style: TextStyle(
              color: Colors.blue,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          // Search & Filter Bar Custom Implementation
          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search architectural projects...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (val) =>
                      ref.read(projectsFilterProvider.notifier).setQuery(val),
                ),
              ),
              ChoiceChip(
                label: const Text("All"),
                selected: homeState.category == 'All',

                onSelected: (_) =>
                    ref.read(projectsFilterProvider.notifier).setCategory('All'),
              ),
              ChoiceChip(
                label: const Text("Mobile Only"),
                selected: homeState.category == 'Mobile',

                onSelected: (_) =>
                    ref.read(projectsFilterProvider.notifier).setCategory('Mobile'),
              ),
              ChoiceChip(
                label: const Text("Full-Stack"),
                selected: homeState.category == 'Full-Stack',
                onSelected: (_) =>
                    ref.read(projectsFilterProvider.notifier).setCategory('Full-Stack'),
              ),
            ],
          ),
          const SizedBox(height: 40),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProjects.length,
            separatorBuilder: (_, __) => const SizedBox(height: 32),
            itemBuilder: (context, index) {
              final project = filteredProjects[index];
              return GlassCard(
                padding: const EdgeInsets.all(32),
                child: Flex(
                  direction: MediaQuery.sizeOf(context).width < 800
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: [
                    Expanded(
                      flex: MediaQuery.sizeOf(context).width < 800 ? 0 : 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            project.description,
                            style: const TextStyle(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: project.technologies
                                .map(
                                  (tech) => Chip(
                                    label: Text(
                                      tech,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 32, height: 32),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      // child: Image.network(
                      //   project.imageUrls.first,
                      //   width: 300,
                      //   height: 200,
                      //   fit: BoxFit.cover,
                      // ),
                      child: Text("net Image URL"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
