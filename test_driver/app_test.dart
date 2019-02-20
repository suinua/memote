import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    final titleTextFinder = find.byValueKey('title');
    final addTaskGroupButton = find.byValueKey('addTaskGroupButton');


    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('start screen?', () async {
      expect(await driver.getText(titleTextFinder), 'Task Groups');
    });

    test('add task group screen?', () async {
      await driver.tap(addTaskGroupButton);
      expect(await driver.getText(titleTextFinder), 'New Task Group');
    });

    test('add task group', () async {

    });

  });
}
