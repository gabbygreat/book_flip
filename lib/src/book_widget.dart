import 'package:book_flip/src/enum.dart';
import 'package:flutter/material.dart';

class BookFlipWidget extends StatefulWidget {
  final List<Widget> content;
  final Widget? coverPage;
  final Alignment alignment;
  final double height;
  final double width;
  final Duration flipDuration;
  final double flipAngle;
  final double pageSpacing;
  final Color shadowColor;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final bool loop;
  final void Function(int)? onPageFlip;

  const BookFlipWidget({
    super.key,
    required this.content,
    this.coverPage,
    this.alignment = const Alignment(-0.2, 0),
    this.height = 400,
    this.width = 300,
    this.flipDuration = const Duration(milliseconds: 800),
    this.flipAngle = 150,
    this.pageSpacing = 0.4,
    this.shadowColor = Colors.black,
    this.shadowBlurRadius = 3,
    this.shadowSpreadRadius = 1,
    this.loop = true,
    this.onPageFlip,
  });

  @override
  State<BookFlipWidget> createState() => _BookFlipWidgetState();
}

class _BookFlipWidgetState extends State<BookFlipWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Widget> content;
  int currentPage = 0;
  late List<double> angles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.flipDuration,
      vsync: this,
    );
    content = [
      if (widget.coverPage != null) widget.coverPage!,
      ...widget.content,
    ].reversed.toList();
    angles = List.generate(content.length, (_) => 0.0);
  }

  void flipForward() {
    if (!widget.loop && (currentPage == content.length - 1)) {
      return;
    }
    _controller.forward(from: 0).whenComplete(() {
      _controller.value = 0;
      if (currentPage == content.length - 1) {
        if (widget.loop) {
          currentPage = 0;
          angles = List.generate(content.length, (_) => 0.0);
        }
      } else {
        currentPage++;
      }
      widget.onPageFlip?.call(currentPage - 1);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GestureDetector(
            onTap: flipForward,
            child: SizedBox(
              height: widget.height,
              width: widget.width,
              child: Stack(
                children: [
                  for (var i in content)
                    Positioned.fill(
                      child: Builder(builder: (context) {
                        angles[currentPage] =
                            _controller.value * widget.flipAngle.toRadians;
                        double angle =
                            angles[content.reversed.toList().indexOf(i)];
                        return Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(angle),
                          child: Container(
                            margin: EdgeInsets.only(left: widget.pageSpacing),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: widget.shadowColor.withOpacity(0.1),
                                  spreadRadius: widget.shadowSpreadRadius,
                                  blurRadius: widget.shadowBlurRadius,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: i,
                          ),
                        );
                      }),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
