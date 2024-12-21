import '../models/task.dart';

class ProjectManagementScreen extends StatefulWidget {
  const ProjectManagementScreen({Key? key}) : super(key: key);

  @override
  State<ProjectManagementScreen> createState() => _ProjectManagementScreenState();
}

class _ProjectManagementScreenState extends State<ProjectManagementScreen> {
  final _projectNameController = TextEditingController();
  final _projectDescController = TextEditingController();
  final _taskNameController = TextEditingController();
  final _taskDescController = TextEditingController();
  String? _selectedProjectId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Projects & Tasks'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Projects'),
              Tab(text: 'Tasks'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildProjectsTab(),
            _buildTasksTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsTab() {
    return Consumer<TimeEntryProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _projectNameController,
                    decoration: const InputDecoration(
                      labelText: 'Project Name',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _projectDescController,
                    decoration: const InputDecoration(
                      labelText: 'Project Description',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_projectNameController.text.isNotEmpty) {
                        final project = Project(
                          name: _projectNameController.text,
                          description: _projectDescController.text,
                        );
                        provider.addProject(project);
                        _projectNameController.clear();
                        _projectDescController.clear();
                      }
                    },
                    child: const Text('Add Project'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.projects.length,
                itemBuilder: (context, index) {
                  final project = provider.projects[index];
                  return ListTile(
                    title: Text(project.name),
                    subtitle: Text(project.description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.deleteProject(project.id),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTasksTab() {
    return Consumer<TimeEntryProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedProjectId,
                    hint: const Text('Select Project'),
                    items: provider.projects.map((project) {
                      return DropdownMenuItem(
                        value: project.id,
                        child: Text(project.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProjectId = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _taskNameController,
                    decoration: const InputDecoration(
                      labelText: 'Task Name',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _taskDescController,
                    decoration: const InputDecoration(
                      labelText: 'Task Description',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _selectedProjectId == null ? null : () {
                      if (_taskNameController.text.isNotEmpty) {
                        final task = Task(
                          projectId: _selectedProjectId!,
                          name: _taskNameController.text,
                          description: _taskDescController.text,
                        );
                        provider.addTask(task);
                        _taskNameController.clear();
                        _taskDescController.clear();
                      }
                    },
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.tasks.length,
                itemBuilder: (context, index) {
                  final task = provider.tasks[index];
                  final project = provider.projects
                      .firstWhere((p) => p.id == task.projectId,
                          orElse: () => Project(
                              name: 'Unknown Project', description: ''));
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text('${project.name}\n${task.description}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.deleteTask(task.id),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
