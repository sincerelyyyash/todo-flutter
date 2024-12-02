# ToDoList App

## Overview

The **ToDoList App** is a simple, intuitive Flutter application designed to allow users to create, manage, and prioritize their tasks. It helps users stay organized by enabling them to add tasks, set due dates, manage priorities, and receive reminders. The app is built with a user-friendly interface and follows the Material Design guidelines.

## Features

- **Create, Edit, and Delete Tasks**: Users can easily create tasks with a title, description, priority, and due date. Tasks can be edited or deleted as needed.
- **Prioritize Tasks**: Users can assign priority levels to tasks (low, medium, high) to help them focus on the most important tasks first.
- **Set Reminders**: Reminders can be set for tasks that are due soon, notifying the user about upcoming deadlines.
- **Task Sorting**: Tasks can be sorted by priority, due date, or creation date to help users better organize their to-do list.
- **Search Functionality**: Users can search for tasks by title or keyword to quickly find specific tasks.
- **Persistent Data**: The app saves user data even if the app is closed or the device is restarted.
- **Push Notifications**: The app pushes notifications to the user based on the expiration of their tasks.

## Technologies Used

- **Flutter**: The app is built using Flutter, the cross-platform framework for creating mobile applications.
- **Dart**: The programming language used for developing the app.
- **GetX**: A lightweight and powerful state management solution used to manage the app's state.
- **Material Design**: The app follows Material Design guidelines for the UI to ensure consistency and usability.

## App Architecture

The app follows the **Model-View-ViewModel (MVVM)** architecture pattern to separate concerns and improve maintainability. The core components are:

- **Model**: Represents the data (tasks, priority, due date, etc.).
- **View**: The UI layer, which displays the tasks to the user.
- **ViewModel**: Contains the logic for interacting with the data (e.g., creating tasks, updating task completion status, sorting tasks).

## Requirements

The app fulfills the following requirements:

1. **Task Management**: Allows users to create, edit, and delete tasks, with a title, description, priority level, and due date.
2. **Task Prioritization**: Users can assign priority levels to tasks.
3. **Task Reminders**: Notifications for tasks due soon.
4. **Sorting**: Tasks can be sorted by priority, due date, or creation date.
5. **Search Functionality**: Users can search for tasks by title or keyword.
6. **Data Persistence**: Saves user data across app restarts.
7. **Push Notifications**: Reminds users about tasks with upcoming due dates.
8. **Clean and Well-Documented Code**: The code is written with clarity and maintainability in mind.

## Screenshots

_Include screenshots of your app here to demonstrate the UI and features._

## Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/sincerelyyyash/todo-flutter.git
   ```

2. **Install dependencies**:
   Navigate to the project directory and install the dependencies:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   Make sure your device is connected or an emulator is running, then execute:
   ```bash
   flutter run
   ```

## App Design

### Home Screen
- **Task List**: Displays the list of tasks, with options to edit, delete, and mark tasks as completed.
- **Floating Action Button**: Allows users to add a new task.
- **Task Sorting**: Users can sort tasks based on priority, due date, or creation date via the app's top menu.

### Task Details Screen
- **Task Information**: Displays the title, description, priority, created date, and due date for each task.
- **Edit Option**: Users can edit the task details.
- **Delete Option**: Users can delete tasks from the task detail screen.
- **Completed Status**: Checkbox to mark tasks as completed.

### Task Editing Screen
- **Add/Edit Task**: A form that allows users to add a new task or edit an existing one.
- **Priority and Due Date**: Users can set the priority and due date of the task.

### Notifications
- **Push Notifications**: The app sends reminders to users when tasks are nearing their due date.

## State Management

The app uses the **GetX** state management pattern to handle the application's state. This allows for reactive UI updates and clean separation of concerns between the UI and the business logic.

- **GetX Controllers**: Controllers are used for managing the task data and user actions such as adding, editing, and deleting tasks.
- **Reactive State**: UI elements react to changes in the state, such as marking tasks as completed or updating task details.

## Unit Tests

Unit tests have been written for the critical parts of the application, such as task creation, task updates, and data persistence.


## Design Decisions

- **MVVM Architecture**: I chose MVVM to separate concerns between UI, business logic, and data, ensuring better maintainability and testability.
- **GetX**: This lightweight state management solution was used because it provides a simple yet effective way to manage state and dependencies.
- **Material Design**: Following Material Design ensures that the app's UI is intuitive, modern, and consistent across different devices.
- **Persistence**: Local storage (e.g., shared preferences, SQLite, or Hive) is used to store tasks persistently, ensuring that data is retained across app restarts.

## Conclusion

This ToDoList app offers a simple yet powerful tool to manage tasks, set priorities, and receive notifications for due dates. It is built using modern Flutter practices, following the MVVM architecture for scalability and maintainability. The app is fully functional and user-friendly, with support for task creation, editing, deletion, reminders, and sorting.



