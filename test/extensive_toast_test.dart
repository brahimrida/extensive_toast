import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:extensive_toast/extensive_toast.dart';

void main() {

  testWidgets('inserts a toast', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return const SizedBox();
          },
        ),
      ),
    ),
  );

  final context = tester.element(find.byType(SizedBox));


  ExtensiveToastManager.insertToast(
    context,
    toast:ExtensiveToast(
      title: 'title',
      body: 'body',
    ),
  );


  expect(ExtensiveToastManager.count, 1);

  ExtensiveToastManager.clearAllToasts();

    expect(ExtensiveToastManager.count, 0);

});


testWidgets('removes a toast by tapping it', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => const SizedBox(),
        ),
      ),
    ),
  );

  final context = tester.element(find.byType(SizedBox));

  ExtensiveToastManager.insertToast(
    context,
    toast: ExtensiveToast(
      title: 'title',
      body: 'body',
      removeOnTap: true,
      autoDismiss: false,
      enterDuration: const Duration(milliseconds: 200),
    ),
  );

  // Render the newly inserted OverlayEntry.
  await tester.pump(Duration(milliseconds: 300));

  final toast = find.byType(Container);

  expect(toast, findsOneWidget);

  await tester.tap(toast);

  // Let the removal happen.
  await tester.pump();

  expect(ExtensiveToastManager.count, 0);
});

testWidgets('removes a toast by auto dismiss', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => const SizedBox(),
        ),
      ),
    ),
  );

  final context = tester.element(find.byType(SizedBox));

  ExtensiveToastManager.insertToast(
    context,
    toast: ExtensiveToast(
      title: 'title',
      body: 'body',
      autoDismiss: true,
      enterDuration: const Duration(milliseconds: 200),
      dismissAfter: const Duration(milliseconds: 250),
      exitDuration: const Duration(milliseconds: 200),
    ),
  );

  await tester.pump();

  expect(ExtensiveToastManager.count, 1);

  await tester.pump(const Duration(milliseconds: 250));

  expect(ExtensiveToastManager.count, 1);

  await tester.pumpAndSettle();

  expect(ExtensiveToastManager.count, 0);
});
  testWidgets('inserts dozen of toasts at the exact same time and wipe them', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return const SizedBox();
          },
        ),
      ),
    ),
  );

  final context = tester.element(find.byType(SizedBox));

    int add = 0;
    int target = 300; 

  do{
      ExtensiveToastManager.insertToast(
        context,
        toast:ExtensiveToast(
          title: 'title',
          body: 'body',
        ),
      );
      add++;
    } while (
        add != target
      );

   expect(ExtensiveToastManager.count, target);

   ExtensiveToastManager.clearAllToasts();

    expect(ExtensiveToastManager.count, 0);
});
}
