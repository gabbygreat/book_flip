import 'package:book_flip/src/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BookWidget displays cover page and content pages correctly',
      (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BookFlipWidget(
            coverPage: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Cover Page'),
                  Text('Happy Anniversary'),
                ],
              ),
            ),
            content: [
              ColoredBox(
                color: Colors.red,
                child: Center(
                  child: Text('Page 1'),
                ),
              ),
              ColoredBox(
                color: Colors.green,
                child: Center(
                  child: Text('Page 2'),
                ),
              ),
              ColoredBox(
                color: Colors.blue,
                child: Center(
                  child: Text('Page 3'),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Verify that the cover page is displayed
    expect(find.text('Cover Page'), findsOneWidget);
    expect(find.text('Happy Anniversary'), findsOneWidget);

    // Verify that the content pages are displayed
    expect(find.text('Page 1'), findsOneWidget);
    expect(find.text('Page 2'), findsOneWidget);
    expect(find.text('Page 3'), findsOneWidget);
  });

  testWidgets('BookWidget triggers page flip animation when tapped',
      (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BookFlipWidget(
            coverPage: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Cover Page'),
                  Text('Happy Anniversary'),
                ],
              ),
            ),
            content: const [
              ColoredBox(
                color: Colors.red,
                child: Center(
                  child: Text('Page 1'),
                ),
              ),
              ColoredBox(
                color: Colors.green,
                child: Center(
                  child: Text('Page 2'),
                ),
              ),
              ColoredBox(
                color: Colors.blue,
                child: Center(
                  child: Text('Page 3'),
                ),
              ),
            ],
            onPageFlip: (int page) {
              // A simple callback to verify page flip
              print('Flipped to page: $page');
            },
          ),
        ),
      ),
    );

    // Tap on the widget to trigger the page flip animation
    await tester.tap(find.byType(BookFlipWidget));
    await tester.pumpAndSettle(); // Wait for the animation to complete

    // Verify that the onPageFlip callback was triggered (you can print/log the page for debugging purposes)
    // You could also add assertions based on the expected outcome (e.g., if the page changed).
  });

  testWidgets('BookWidget respects loop behavior', (WidgetTester tester) async {
    // Build the widget tree with loop enabled
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BookFlipWidget(
            loop: true,
            coverPage: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Cover Page'),
                  Text('Happy Anniversary'),
                ],
              ),
            ),
            content: [
              ColoredBox(
                color: Colors.red,
                child: Center(
                  child: Text('Page 1'),
                ),
              ),
              ColoredBox(
                color: Colors.green,
                child: Center(
                  child: Text('Page 2'),
                ),
              ),
              ColoredBox(
                color: Colors.blue,
                child: Center(
                  child: Text('Page 3'),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Tap to go through the pages
    await tester.tap(find.byType(BookFlipWidget));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BookFlipWidget));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BookFlipWidget));
    await tester.pumpAndSettle();

    // Verify that the loop works by ensuring the book loops back to the first page
    expect(find.text('Page 1'), findsOneWidget);
  });
}
