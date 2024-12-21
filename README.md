# Time Tracker App

A Flutter-based time tracking application that helps users monitor time spent on various tasks and projects. The app provides local storage functionality to persist data between sessions.

## Features

- Track time spent on tasks and projects
- Add detailed time entries with:
  - Project selection
  - Task selection
  - Total time spent
  - Date
  - Notes
- Group time entries by projects
- Manage projects and tasks
- Local data persistence
- Material Design UI

## Prerequisites

Before running this project, make sure you have the following installed:
- Flutter (2.19.0 or higher)
- Dart SDK
- Android Studio / Xcode (for running on emulators/simulators)

## Dependencies

The app uses the following dependencies:
```yaml
dependencies:
  flutter:
    sdk: flutter
  intl: ^0.18.0
  provider: ^6.0.5
  collection: ^1.17.0
  localstorage: ^4.0.0+1
  uuid: ^3.0.7
  cupertino_icons: ^1.0.2
```

## Installation

1. Clone the repository:
```bash
git clone [repository-url]
```

2. Navigate to the project directory:
```bash
cd timetracker
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── models/
│   ├── project.dart
│   ├── task.dart
│   └── time_entry.dart
├── providers/
│   └── time_entry_provider.dart
├── screens/
│   ├── home_screen.dart
│   ├── add_time_entry_screen.dart
│   └── project_management_screen.dart
└── main.dart
```

## Usage

1. **Adding a Project:**
   - Navigate to settings (gear icon)
   - Go to the Projects tab
   - Fill in project name and description
   - Click "Add Project"

2. **Adding a Task:**
   - Navigate to settings
   - Go to the Tasks tab
   - Select a project
   - Fill in task details
   - Click "Add Task"

3. **Recording Time:**
   - Click the + button on the home screen
   - Select project and task
   - Enter time spent
   - Select date
   - Add optional notes
   - Click "Save Entry"

4. **Viewing Time Entries:**
   - All entries are displayed on the home screen
   - Entries are grouped by project
   - Expand project to see individual entries

5. **Deleting Entries:**
   - Click the delete icon next to any entry to remove it
   - Deleting a project will delete all associated tasks and time entries
   - Deleting a task will delete all associated time entries

## Data Storage

The app uses local storage to persist data between sessions. All data is stored in a JSON file named `timetracker.json` in the application's local storage directory.

## State Management

The app uses Provider for state management. The `TimeEntryProvider` class manages:
- Time entries
- Projects
- Tasks
- Local storage operations

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Provider package for state management
- LocalStorage package for data persistence