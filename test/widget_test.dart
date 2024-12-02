import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:todo/view/screens/home_screen.dart';
import 'package:todo/view/screens/add_task_screen.dart';
import 'package:todo/view/screens/task_detail_screen.dart';
import 'package:todo/view_model/task_view_model.dart';
import 'package:todo/data/models/task.model.dart';
import 'package:todo/main.dart';

void main() {
  setUp(() {
    Get.put(TaskViewModel());
  });

  testWidgets('Task can be added and displayed in the list',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    expect(find.text('No tasks yet. Add a task!'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(AddTaskScreen), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'New Task');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('New Task'), findsOneWidget);
    expect(find.text('No tasks yet. Add a task!'), findsNothing);
  });

  testWidgets('Task can be marked as completed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Test Task');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Test Task'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            widget.style?.decoration == TextDecoration.lineThrough),
        findsOneWidget);
  });

  testWidgets('Task can be deleted', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Test Task for Deletion');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Test Task for Deletion'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    expect(find.text('Test Task for Deletion'), findsNothing);
  });

  testWidgets('Task details are displayed correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Task with Details');
    await tester.enterText(
        find.byType(TextField).last, 'This is a detailed task description');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Tap on the task to view details
    await tester.tap(find.text('Task with Details'));
    await tester.pumpAndSettle();

    expect(find.text('Task with Details'), findsOneWidget);
    expect(find.text('This is a detailed task description'), findsOneWidget);
  });
}
