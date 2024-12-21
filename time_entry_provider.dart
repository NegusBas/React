import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';

class TimeEntryProvider with ChangeNotifier {
  final LocalStorage storage = LocalStorage('timetracker.json');
  List<TimeEntry> _timeEntries = [];
  List<Project> _projects = [];
  List<Task> _tasks = [];

  List<TimeEntry> get timeEntries => _timeEntries;
  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;

  Future<void> initializeData() async {
    await storage.ready;
    
    // Load projects
    final projectsData = storage.getItem('projects');
    if (projectsData != null) {
      _projects = (projectsData as List)
          .map((item) => Project.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }

    // Load tasks
    final tasksData = storage.getItem('tasks');
    if (tasksData != null) {
      _tasks = (tasksData as List)
          .map((item) => Task.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }

    // Load time entries
    final entriesData = storage.getItem('timeEntries');
    if (entriesData != null) {
      _timeEntries = (entriesData as List)
          .map((item) => TimeEntry.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    
    notifyListeners();
  }

  Future<void> addTimeEntry(TimeEntry entry) async {
    _timeEntries.add(entry);
    await _saveTimeEntries();
    notifyListeners();
  }

  Future<void> deleteTimeEntry(String id) async {
    _timeEntries.removeWhere((entry) => entry.id == id);
    await _saveTimeEntries();
    notifyListeners();
  }

  Future<void> addProject(Project project) async {
    _projects.add(project);
    await _saveProjects();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _saveTasks();
    notifyListeners();
  }

  Future<void> deleteProject(String id) async {
    _projects.removeWhere((project) => project.id == id);
    _tasks.removeWhere((task) => task.projectId == id);
    _timeEntries.removeWhere((entry) => entry.projectId == id);
    await _saveAll();
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    _timeEntries.removeWhere((entry) => entry.taskId == id);
    await _saveAll();
    notifyListeners();
  }

  Future<void> _saveTimeEntries() async {
    await storage.setItem('timeEntries', 
      _timeEntries.map((entry) => entry.toJson()).toList());
  }

  Future<void> _saveProjects() async {
    await storage.setItem('projects', 
      _projects.map((project) => project.toJson()).toList());
  }

  Future<void> _saveTasks() async {
    await storage.setItem('tasks', 
      _tasks.map((task) => task.toJson()).toList());
  }

  Future<void> _saveAll() async {
    await _saveTimeEntries();
    await _saveProjects();
    await _saveTasks();
  }
}