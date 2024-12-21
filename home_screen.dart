import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../providers/time_entry_provider.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import 'add_time_entry_screen.dart';
import 'project_management_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectManagementScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          // Group entries by project
          final groupedEntries = provider.timeEntries.groupListsBy(
            (entry) => entry.projectId,
          );

          return ListView.builder(
            itemCount: groupedEntries.length,
            itemBuilder: (context, index) {
              final projectId = groupedEntries.keys.elementAt(index);
              final projectEntries = groupedEntries[projectId]!;
              final project = provider.projects
                  .firstWhere((p) => p.id == projectId, 
                    orElse: () => Project(
                      name: 'Unknown Project', 
                      description: ''
                    ));

              return ExpansionTile(
                title: Text(project.name),
                children: projectEntries.map((entry) {
                  final task = provider.tasks
                      .firstWhere((t) => t.id == entry.taskId, 
                        orElse: () => Task(
                          projectId: projectId,
                          name: 'Unknown Task', 
                          description: ''
                        ));

                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text(
                      '${entry.timeSpent} hours - ${entry.date.toString().split(' ')[0]}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.deleteTimeEntry(entry.id),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTimeEntryScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
