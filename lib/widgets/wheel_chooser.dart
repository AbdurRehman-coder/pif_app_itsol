import 'package:flutter/widgets.dart';

class WheelChoice<T> {
  WheelChoice({required this.value, required this.title});

  final T value;
  final String title;
}

class WheelChooser<T> extends StatefulWidget {
  const WheelChooser({
    required this.onValueChanged,
    required this.datas,
    super.key,
    this.selectTextStyle,
    this.unSelectTextStyle,
    this.startPosition = 0,
    this.squeeze = 1.0,
    this.itemSize = _defaultItemSize,
    this.magnification = 1,
    this.perspective = 0.01,
    this.listWidth,
    this.listHeight,
    this.controller,
    this.horizontal = false,
    this.isInfinite = false,
    this.physics,
  })  : assert(perspective <= 0.01, 'Perspective Value Issue'),
        assert(
          controller == null || startPosition == null,
          'StartPosition and Controller Should not be null',
        ),
        children = null,
        choices = null,
        onChoiceChanged = null;

  const WheelChooser.choices({
    required this.onChoiceChanged,
    required this.choices,
    super.key,
    this.selectTextStyle,
    this.unSelectTextStyle,
    this.startPosition = 0,
    this.squeeze = 1.0,
    this.itemSize = _defaultItemSize,
    this.magnification = 1,
    this.perspective = 0.01,
    this.listWidth,
    this.listHeight,
    this.controller,
    this.horizontal = false,
    this.isInfinite = false,
    this.physics,
  })  : assert(perspective <= 0.01, 'Perspective Value Issue'),
        assert(
          controller == null || startPosition == null,
          'StartPosition and Controller Should not be null',
        ),
        children = null,
        datas = null,
        onValueChanged = null;

  WheelChooser.custom({
    required this.onValueChanged,
    required this.children,
    super.key,
    this.onChoiceChanged,
    this.datas,
    this.startPosition = 0,
    this.squeeze = 1.0,
    this.itemSize = _defaultItemSize,
    this.magnification = 1,
    this.perspective = 0.01,
    this.listWidth,
    this.listHeight,
    this.controller,
    this.horizontal = false,
    this.isInfinite = false,
    this.physics,
  })  : assert(perspective <= 0.01, 'Perspective Value Issue'),
        assert(datas == null || datas.length == children!.length, 'Items Should not be null'),
        assert(
          controller == null || startPosition == null,
          'StartPosition and Controller Should not be null',
        ),
        selectTextStyle = null,
        unSelectTextStyle = null,
        choices = null;

  const WheelChooser.byController({
    required FixedExtentScrollController this.controller,
    required this.onValueChanged,
    required this.datas,
    super.key,
    this.selectTextStyle,
    this.unSelectTextStyle,
    this.squeeze = 1.0,
    this.itemSize = _defaultItemSize,
    this.magnification = 1,
    this.perspective = 0.01,
    this.listWidth,
    this.listHeight,
    this.horizontal = false,
    this.isInfinite = false,
    this.physics,
  })  : assert(perspective <= 0.01, 'Perspective Value Issue'),
        children = null,
        choices = null,
        onChoiceChanged = null,
        startPosition = null;
  final TextStyle? selectTextStyle;
  final TextStyle? unSelectTextStyle;
  final void Function(dynamic)? onValueChanged;
  final void Function(dynamic)? onChoiceChanged;
  final List<dynamic>? datas;
  final List<WheelChoice<T>>? choices;
  final int? startPosition;
  final double itemSize;
  final double squeeze;
  final double magnification;
  final double perspective;
  final double? listHeight;
  final double? listWidth;
  final List<Widget>? children;
  final bool horizontal;
  final bool isInfinite;
  final FixedExtentScrollController? controller;
  final ScrollPhysics? physics;
  static const double _defaultItemSize = 48;

  @override
  State createState() {
    return _WheelChooserState<T>();
  }
}

class _WheelChooserState<T> extends State<WheelChooser<T>> {
  FixedExtentScrollController? fixedExtentScrollController;
  int? currentPosition;

  bool _hasDatas() {
    return widget.datas != null;
  }

  bool _hasChildren() {
    return widget.children != null;
  }

  bool _hasChoices() {
    return widget.choices != null;
  }

  dynamic _findDatasByIndex(int anIndex) {
    return widget.datas![anIndex];
  }

  bool _isValidChoicePosition(int anIndex) {
    return (anIndex >= 0) && (anIndex < widget.choices!.length);
  }

  @override
  void initState() {
    super.initState();
    currentPosition = widget.controller?.initialItem ?? widget.startPosition;
    fixedExtentScrollController =
        widget.controller ?? FixedExtentScrollController(initialItem: currentPosition ?? 0);
  }

  void _listener(int position) {
    setState(() {
      currentPosition = position;
    });
    if (_hasChildren()) {
      widget.onValueChanged!(currentPosition);
    } else {
      if (_hasDatas()) {
        widget.onValueChanged!(_findDatasByIndex(currentPosition!));
      } else {
        if ((_hasChoices()) && (_isValidChoicePosition(currentPosition!))) {
          final aChoices = widget.choices!;
          widget.onChoiceChanged!(aChoices[currentPosition!].value);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.horizontal ? 3 : 0,
      child: SizedBox(
        height: widget.listHeight ?? double.infinity,
        width: widget.listWidth ?? double.infinity,
        child: _getListWheelScrollView(),
      ),
    );
  }

  List<Widget> _buildItems() {
    if (_hasDatas()) {
      return _buildListItems();
    } else {
      if (widget.children != null) {
        return _convertListItems();
      } else {
        if (_hasChoices()) {
          return _buildChoiceItems();
        } else {
          return [];
        }
      }
    }
  }

  Widget _getListWheelScrollView() {
    if (widget.isInfinite) {
      return ListWheelScrollView.useDelegate(
        onSelectedItemChanged: _listener,
        perspective: widget.perspective,
        squeeze: widget.squeeze,
        controller: fixedExtentScrollController,
        physics: FixedExtentScrollPhysics(parent: widget.physics),
        childDelegate: ListWheelChildLoopingListDelegate(children: _buildItems()),
        useMagnifier: true,
        magnification: widget.magnification,
        itemExtent: widget.itemSize,
      );
    } else {
      return ListWheelScrollView(
        onSelectedItemChanged: _listener,
        perspective: widget.perspective,
        squeeze: widget.squeeze,
        controller: fixedExtentScrollController,
        physics: FixedExtentScrollPhysics(parent: widget.physics),
        useMagnifier: true,
        magnification: widget.magnification,
        itemExtent: widget.itemSize,
        children: _buildItems(),
      );
    }
  }

  List<Widget> _buildListItems() {
    final data = widget.datas!;
    final result = <Widget>[];
    for (var i = 0; i < data.length; i++) {
      result.add(
        RotatedBox(
          quarterTurns: widget.horizontal ? 1 : 0,
          child: Center(
            child: Text(
              data[i].toString(),
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
              style: i == currentPosition ? widget.selectTextStyle : widget.unSelectTextStyle,
            ),
          ),
        ),
      );
    }
    return result;
  }

  List<Widget> _buildChoiceItems() {
    final aChoices = widget.choices!;
    final result = <Widget>[];
    for (var i = 0; i < aChoices.length; i++) {
      result.add(
        RotatedBox(
          quarterTurns: widget.horizontal ? 1 : 0,
          child: Center(
            child: Text(
              aChoices[i].title,
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
              style: i == currentPosition ? widget.selectTextStyle : widget.unSelectTextStyle,
            ),
          ),
        ),
      );
    }
    return result;
  }

  List<Widget> _convertListItems() {
    final children = widget.children;
    if (children == null) {
      return [];
    }
    if (widget.horizontal) {
      final result = <Widget>[];
      for (var i = 0; i < children.length; i++) {
        result.add(
          RotatedBox(
            quarterTurns: 1,
            child: children[i],
          ),
        );
      }
      return result;
    } else {
      return children;
    }
  }
}
