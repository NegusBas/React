import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/time_entry_provider.dart';
import '../models/time_entry.dart';

class AddTimeEntryScreen extends StatefulWidget {
  const AddTimeEntryScreen({Key? key}) : super(key: key);

  @override
  State<AddTimeEntryScreen> createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  String? _selectedProjectId;
  String? _selectedTaskId;
  final _timeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Time Entry'),
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return Padding(
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
                      _selectedTaskId = null;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedTaskId,
                  hint: const Text('Select Task'),
                  items: provider.tasks
                      .where((task) => task.projectId == _selectedProjectId)
                      .map((task) {
                    return DropdownMenuItem(
                      value: task.id,
                      child: Text(task.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTaskId = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _timeController,
                  decoration: const InputDecoration(
                    labelText: 'Time Spent (hours)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Date'),
                  subtitle: Text(_selectedDate.toString().split(' ')[0]),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedProjectId != null &&
                        _selectedTaskId != null &&
                        _timeController.text.isNotEmpty) {
                      final entry = TimeEntry(
                        projectId: _selectedProjectId!,
                        taskId: _selectedTaskId!,
                        timeSpent: double.parse(_timeController.text),
                        date: _selectedDate,
                        notes: _notesController.text,
                      );
                      provider.addTimeEntry(entry);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Entry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
