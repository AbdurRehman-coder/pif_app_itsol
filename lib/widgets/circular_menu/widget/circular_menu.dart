import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

import 'package:pif_flutter/widgets/circular_menu/circular_menu.dart';

class CircularMenu extends StatefulWidget {
  /// use global key to control animation anywhere in the code
  final GlobalKey<CircularMenuState>? key;

  /// list of CircularMenuItem contains at least two items.
  final List<CircularMenuItem> items;

  /// menu alignment
  final AlignmentGeometry alignment;

  /// menu radius
  final double radius;

  /// widget holds actual page content
  final Widget? backgroundWidget;

  /// animation duration
  final Duration animationDuration;

  /// animation curve in forward
  final Curve curve;

  /// animation curve in rverse
  final Curve reverseCurve;
  ValueChanged<bool>? onChanged;

  /// callback
  final VoidCallback? toggleButtonOnPressed;
  final Color? toggleButtonColor;
  final double toggleButtonSize;
  final List<BoxShadow>? toggleButtonBoxShadow;
  final double toggleButtonPadding;
  final double toggleButtonMargin;
  final Color? toggleButtonIconColor;
  final Widget openToggleIcon;
  final Widget closeToggleIcon;
  final bool isHided;
  AnimationController animationController;

  /// staring angle in clockwise radian
  final double? startingAngleInRadian;

  /// ending angle in clockwise radian
  final double? endingAngleInRadian;

  /// creates a circular menu with specific [radius] and [alignment] .
  /// [toggleButtonElevation] ,[toggleButtonPadding] and [toggleButtonMargin] must be
  /// equal or greater than zero.
  /// [items] must not be null and it must contains two elements at least.
  CircularMenu({
    required this.animationController,
    required this.items,
    this.alignment = Alignment.bottomCenter,
    this.radius = 100,
    this.isHided = false,
    this.backgroundWidget,
    this.animationDuration = const Duration(milliseconds: 500),
    this.curve = Curves.bounceOut,
    this.reverseCurve = Curves.fastOutSlowIn,
    this.toggleButtonOnPressed,
    this.toggleButtonColor,
    this.toggleButtonBoxShadow,
    this.toggleButtonMargin = 10,
    this.toggleButtonPadding = 10,
    this.toggleButtonSize = 40,
    this.toggleButtonIconColor,
    this.onChanged,
    this.openToggleIcon = const Icon(Icons.menu),
    this.closeToggleIcon = const Icon(Icons.close),
    this.key,
    this.startingAngleInRadian,
    this.endingAngleInRadian,
  })
      : assert(items.isNotEmpty, 'items can not be empty list'),
        assert(items.length > 1, 'if you have one item no need to use a Menu'),
        super(key: key);

  @override
  CircularMenuState createState() => CircularMenuState();
}

class CircularMenuState extends State<CircularMenu>
    with SingleTickerProviderStateMixin {
  double? _completeAngle;
  late double _initialAngle;
  double? _endAngle;
  double? _startAngle;
  late int _itemsCount;
  late Animation<double> _animation;

  /// forward animation
  void forwardAnimation() {
    widget.animationController.forward();
  }

  /// reverse animation
  void reverseAnimation() {
    widget.animationController.reverse();
  }

  @override
  void initState() {
    _configure();
    widget.animationController
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    );

    _itemsCount = widget.items.length;
    super.initState();
  }

  void _configure() {
    if (widget.startingAngleInRadian != null ||
        widget.endingAngleInRadian != null) {
      if (widget.startingAngleInRadian == null) {
        throw 'startingAngleInRadian can not be null';
      }
      if (widget.endingAngleInRadian == null) {
        throw 'endingAngleInRadian can not be null';
      }

      if (widget.startingAngleInRadian! < 0) {
        throw 'startingAngleInRadian has to be in clockwise radian';
      }
      if (widget.endingAngleInRadian! < 0) {
        throw 'endingAngleInRadian has to be in clockwise radian';
      }
      _startAngle = (widget.startingAngleInRadian! / math.pi) % 2;
      _endAngle = (widget.endingAngleInRadian! / math.pi) % 2;
      if (_endAngle! < _startAngle!) {
        throw 'startingAngleInRadian can not be greater than endingAngleInRadian';
      }
      _completeAngle = _startAngle == _endAngle
          ? 2 * math.pi
          : (_endAngle! - _startAngle!) * math.pi;
      _initialAngle = _startAngle! * math.pi;
    } else {
      switch (widget.alignment.toString()) {
        case 'Alignment.bottomCenter':
          _completeAngle = 1 * math.pi;
          _initialAngle = 1 * math.pi;
          break;
        case 'Alignment.topCenter':
          _completeAngle = 1 * math.pi;
          _initialAngle = 0 * math.pi;
          break;
        case 'Alignment.centerLeft':
          _completeAngle = 1 * math.pi;
          _initialAngle = 1.5 * math.pi;
          break;
        case 'Alignment.centerRight':
          _completeAngle = 1 * math.pi;
          _initialAngle = 0.5 * math.pi;
          break;
        case 'Alignment.center':
          _completeAngle = 2 * math.pi;
          _initialAngle = 0 * math.pi;
          break;
        case 'Alignment.bottomRight':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 1 * math.pi;
          break;
        case 'Alignment.bottomLeft':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 1.5 * math.pi;
          break;
        case 'Alignment.topLeft':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 0 * math.pi;
          break;
        case 'Alignment.topRight':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 0.5 * math.pi;
          break;
        default:
          throw 'startingAngleInRadian and endingAngleInRadian can not be null';
      }
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    _configure();
    super.didUpdateWidget(oldWidget);
  }

  List<Widget> _buildMenuItems() {
    List<Widget> items = [];
    widget.items.asMap().forEach((index, item) {
      items.add(
        Positioned.fill(
          child: Align(
            alignment: widget.alignment,
            child: Transform.translate(
              offset: Offset.fromDirection(
                _completeAngle == (2 * math.pi)
                    ? (_initialAngle + (_completeAngle! / _itemsCount) * index)
                    : (_initialAngle +
                    (_completeAngle! / (_itemsCount - 1)) * index),
                _animation.value * widget.radius,
              ),
              child: Transform.scale(
                scale: _animation.value,
                child: Transform.rotate(
                  angle: _animation.value * (math.pi * 2),
                  child: item,
                ),
              ),
            ),
          ),
        ),
      );
    });
    return items;
  }

  Widget _buildMenuButton(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: widget.alignment,
        child: CircularMenuItem(
          icon: null,
          margin: widget.toggleButtonMargin,
          color: widget.toggleButtonColor ?? Theme
              .of(context)
              .primaryColor,
          padding: (-_animation.value * widget.toggleButtonPadding * 0.5) +
              widget.toggleButtonPadding,
          onTap: () {
            widget.animationController.status == AnimationStatus.dismissed
                ? widget.animationController.forward()
                : widget.animationController.reverse();
            if (widget.toggleButtonOnPressed != null) {
              widget.toggleButtonOnPressed!();
            }
          },
          boxShadow: widget.toggleButtonBoxShadow,
          animatedIcon:
          widget.animationController.status == AnimationStatus.dismissed
              ? widget.openToggleIcon
              : widget.closeToggleIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isHided) {
      return Stack(
        children: <Widget>[
          widget.backgroundWidget ?? Container(),
          if (widget.animationController.status !=
              AnimationStatus.dismissed) ...[
            Positioned.fill(
              child: Align(
                alignment: widget.alignment,
                child: Transform.scale(
                  scale: _animation.value,
                  child: Container(
                    height: 150.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          whiteColor,
                          expireBgColor.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(200.r),
                        topRight: Radius.circular(200.r),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (widget.animationController.status !=
              AnimationStatus.dismissed) ...[
            Positioned.fill(
              bottom: 60.h,
              child: Align(
                alignment: widget.alignment,
                child: Transform.scale(
                  scale: _animation.value,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'Quick Actions',
                      style: Style.commonTextStyle(
                        color: expireStatusColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          ..._buildMenuItems(),
          _buildMenuButton(context),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      widget.animationController.dispose();
    }
  }
}
