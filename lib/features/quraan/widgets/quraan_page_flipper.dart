import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuraanRTLPageFlipper extends StatefulWidget {
  final List<File> pages;
  final int initialPage;
  final Function(int)? onPageChanged;

  const QuraanRTLPageFlipper({
    super.key,
    required this.pages,
    this.initialPage = 0,
    this.onPageChanged,
  });

  @override
  State<QuraanRTLPageFlipper> createState() => _QuraanRTLPageFlipperState();
}

class _QuraanRTLPageFlipperState extends State<QuraanRTLPageFlipper>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  int _currentPageIndex = 0;
  bool _isFlipping = false;
  bool _isFlippingForward = true;
  double _dragStartX = 0;
  double _dragCurrentX = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.initialPage;

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _flipAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeInOut,
    ));

    _flipAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (_isFlippingForward) {
            _currentPageIndex = math.min(_currentPageIndex + 1, widget.pages.length - 1);
          } else {
            _currentPageIndex = math.max(_currentPageIndex - 1, 0);
          }
          _isFlipping = false;
        });
        _flipController.reset();
        widget.onPageChanged?.call(_currentPageIndex);
      }
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _startFlip(bool forward) {
    if (_isFlipping) return;

    bool canFlip = forward
        ? _currentPageIndex < widget.pages.length - 1
        : _currentPageIndex > 0;

    if (!canFlip) return;

    setState(() {
      _isFlipping = true;
      _isFlippingForward = forward;
    });

    _flipController.forward();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_isFlipping) return;

    _dragStartX = details.localPosition.dx;
    _dragCurrentX = details.localPosition.dx;
    _isDragging = true;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isDragging || _isFlipping) return;

    setState(() {
      _dragCurrentX = details.localPosition.dx;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_isDragging || _isFlipping) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final dragDistance = _dragCurrentX - _dragStartX;
    final dragThreshold = screenWidth * 0.3;

    setState(() {
      _isDragging = false;
    });

    // RTL: drag left to go to next page, drag right to go to previous page
    if (dragDistance < -dragThreshold) {
      _startFlip(true); // Next page
    } else if (dragDistance > dragThreshold) {
      _startFlip(false); // Previous page
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDragStart,
      onPanUpdate: _handleDragUpdate,
      onPanEnd: _handleDragEnd,
      onTap: () {
        final screenWidth = MediaQuery.of(context).size.width;
        final tapPosition = _dragCurrentX;

        // RTL: tap on left side for next page, right side for previous page
        if (tapPosition < screenWidth * 0.4) {
          _startFlip(true);
        } else if (tapPosition > screenWidth * 0.6) {
          _startFlip(false);
        }
      },
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: QuraanPagePainter(
              currentPage: widget.pages[_currentPageIndex],
              nextPage: _isFlippingForward && _currentPageIndex < widget.pages.length - 1
                  ? widget.pages[_currentPageIndex + 1]
                  : null,
              previousPage: !_isFlippingForward && _currentPageIndex > 0
                  ? widget.pages[_currentPageIndex - 1]
                  : null,
              flipProgress: _isFlipping ? _flipAnimation.value : 0.0,
              isFlippingForward: _isFlippingForward,
              isDragging: _isDragging,
              dragProgress: _isDragging ? (_dragCurrentX - _dragStartX) : 0.0,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class QuraanPagePainter extends CustomPainter {
  final File currentPage;
  final File? nextPage;
  final File? previousPage;
  final double flipProgress;
  final bool isFlippingForward;
  final bool isDragging;
  final double dragProgress;

  QuraanPagePainter({
    required this.currentPage,
    this.nextPage,
    this.previousPage,
    required this.flipProgress,
    required this.isFlippingForward,
    required this.isDragging,
    required this.dragProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Draw background page
    File? backgroundPage;
    if (isFlippingForward && nextPage != null) {
      backgroundPage = nextPage;
    } else if (!isFlippingForward && previousPage != null) {
      backgroundPage = previousPage;
    }

    if (backgroundPage != null && (flipProgress > 0 || isDragging)) {
      _drawPage(canvas, size, backgroundPage, paint);
    }

    // Draw current page with flip effect
    if (flipProgress > 0 || isDragging) {
      _drawFlippingPage(canvas, size, currentPage, paint);
    } else {
      _drawPage(canvas, size, currentPage, paint);
    }
  }

  void _drawPage(Canvas canvas, Size size, File page, Paint paint) {
    // In a real implementation, you'd load and draw the image
    // For now, we'll draw a placeholder
    paint.color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw page content placeholder
    paint.color = Colors.black87;
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'page_label'.trParams({'page': page.path.split('/').last}),
        style: const TextStyle(color: Colors.black87, fontSize: 24),
      ),
      textDirection: TextDirection.rtl,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - textPainter.width - 20, 50));
  }

  void _drawFlippingPage(Canvas canvas, Size size, File page, Paint paint) {
    final progress = isDragging
        ? math.max(0.0, math.min(1.0, dragProgress.abs() / (size.width * 0.8)))
        : flipProgress;

    final flipX = isFlippingForward
        ? size.width * (1 - progress)
        : size.width * progress;

    canvas.save();

    // Create clipping path for the flipping page
    final path = Path();
    final curveOffset = math.sin(progress * math.pi) * 30;

    if (isFlippingForward) {
      // RTL next page flip
      path.moveTo(flipX, 0);
      path.quadraticBezierTo(
          flipX - curveOffset,
          size.height / 2,
          flipX,
          size.height
      );
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.close();
    } else {
      // RTL previous page flip
      path.moveTo(flipX, 0);
      path.quadraticBezierTo(
          flipX + curveOffset,
          size.height / 2,
          flipX,
          size.height
      );
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
      path.close();
    }

    canvas.clipPath(path);

    // Apply 3D transformation
    final matrix = Matrix4.identity();
    final centerX = size.width / 2;
    final rotationY = isFlippingForward
        ? -math.pi * progress * 0.5
        : math.pi * progress * 0.5;

    matrix.setEntry(3, 2, 0.001); // Perspective
    matrix.rotateY(rotationY);

    canvas.transform(matrix.storage);

    // Draw the page
    _drawPage(canvas, size, page, paint);

    canvas.restore();

    // Draw shadow
    _drawShadow(canvas, size, flipX, progress, isFlippingForward);
  }

  void _drawShadow(Canvas canvas, Size size, double flipX, double progress, bool forward) {
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3 * progress)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final shadowPath = Path();
    final curveOffset = math.sin(progress * math.pi) * 30;

    if (forward) {
      shadowPath.moveTo(flipX, 0);
      shadowPath.quadraticBezierTo(
          flipX - curveOffset,
          size.height / 2,
          flipX,
          size.height
      );
    } else {
      shadowPath.moveTo(flipX, 0);
      shadowPath.quadraticBezierTo(
          flipX + curveOffset,
          size.height / 2,
          flipX,
          size.height
      );
    }

    final shadowPaint2 = Paint()
      ..color = Colors.black.withOpacity(0.1 * progress)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(shadowPath, shadowPaint2);
  }

  @override
  bool shouldRepaint(covariant QuraanPagePainter oldDelegate) {
    return oldDelegate.flipProgress != flipProgress ||
        oldDelegate.isDragging != isDragging ||
        oldDelegate.dragProgress != dragProgress ||
        oldDelegate.currentPage != currentPage;
  }
}
