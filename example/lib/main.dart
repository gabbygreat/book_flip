import 'package:flutter/material.dart';
import 'package:book_flip/book_flip.dart';

void main() {
  runApp(const BookWidgetExampleApp());
}

class BookWidgetExampleApp extends StatelessWidget {
  const BookWidgetExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookWidget Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BookWidgetDemo(),
    );
  }
}

class BookWidgetDemo extends StatelessWidget {
  const BookWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookWidget Demo'),
      ),
      body: Center(
        child: BookFlipWidget(
          coverPage: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cover Page',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('Happy Anniversary!'),
              ],
            ),
          ),
          content: const [
            ColoredBox(
              color: Colors.red,
              child: Center(
                child: Text(
                  'Page 1',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            ColoredBox(
              color: Colors.green,
              child: Center(
                child: Text(
                  'Page 2',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            ColoredBox(
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Page 3',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
          flipDuration: const Duration(milliseconds: 1200),
          flipAngle: 160,
          pageSpacing: 0.5,
          shadowColor: Colors.black,
          shadowBlurRadius: 4,
          shadowSpreadRadius: 1,
          loop: true,
          onPageFlip: (page) {
            print('Flipped to page: $page');
          },
        ),
      ),
    );
  }
}
