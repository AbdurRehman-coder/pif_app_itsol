import 'package:flutter/material.dart';

class MarginWidget extends StatefulWidget {
  const MarginWidget({
    required this.child,
    super.key,
    this.horizontal = 0,
    this.vertical = 0,
    this.left = 0,
    this.top = 0,
  });

  final Widget child;
  final double horizontal;
  final double vertical;
  final double top;
  final double left;

  @override
  State<MarginWidget> createState() => _MarginWidgetState();
}

class _MarginWidgetState extends State<MarginWidget> {
  Size childSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    final horizontalMargin = widget.horizontal * 2 * -1;
    final verticalMargin = widget.vertical * 2 * -1;

    final newWidth = childSize.width + horizontalMargin;
    final newHeight = childSize.height + verticalMargin;

    if (childSize != Size.zero) {
      return LimitedBox(
        maxWidth: newWidth,
        maxHeight: newHeight,
        child: OverflowBox(
          maxWidth: newWidth,
          maxHeight: newHeight,
          child: Transform.translate(
            offset: Offset(widget.left, widget.top),
            child: SizedBox(
              width: newWidth,
              height: newHeight,
              child: widget.child,
            ),
          ),
        ),
      );
    }

    return _SizeProviderWidget(
      child: widget.child,
      onChildSize: (size) {
        setState(() => childSize = size);
      },
    );
  }
}

class _SizeProviderWidget extends StatefulWidget {
  const _SizeProviderWidget({
    required this.onChildSize,
    required this.child,
  });

  final Widget child;
  final void Function(Size) onChildSize;

  @override
  State<_SizeProviderWidget> createState() => _SizeProviderWidgetState();
}

class _SizeProviderWidgetState extends State<_SizeProviderWidget> {
  @override
  void initState() {
    _onResize();
    super.initState();
  }

  void _onResize() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.size is Size) {
        widget.onChildSize(context.size!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
