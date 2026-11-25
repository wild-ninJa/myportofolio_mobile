import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (project.projectImageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Image.network(
                project.projectImageUrl,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Tech stack: ${project.techStack}'),
          const SizedBox(height: 12),
          Text(project.description),
          const SizedBox(height: 12),
          Text('Link: ${project.projectUrl}'),
        ],
      ),
    );
  }
}