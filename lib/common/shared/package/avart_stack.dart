import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  const AvatarStack({
    Key? key,
    required this.avatars,
    this.settings,
    this.infoWidgetBuilder,
    this.width,
    this.height,
    this.borderWidth,
    this.borderColor,
  }) : super(key: key);

  /// List of avatars.
  /// If you have avatars in Internet you can use [NetworkImage],
  /// for assets you can use [ExactAssetImage]
  /// for file you can use [FileImage]
  final List<Widget> avatars;

  /// Algorithm for calculating positions
  final Positions? settings;

  /// Callback for drawing information of hidden widgets. Something like: (+7)
  final InfoWidgetBuilder? infoWidgetBuilder;

  /// Width of area the avatar stack is placed in.
  /// If [width] is not set it will be get from parent.
  final double? width;

  /// Height of the each elements of the avatar stack.
  /// If [height] is not set it will be get from parent.
  final double? height;

  /// Thickness of the avatar border
  final double? borderWidth;

  /// Color of the avatar border
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final _settings =
        settings ?? RestrictedPositions(maxCoverage: 0.3, minCoverage: 0.1);

    final border = BorderSide(
      color: borderColor ?? Theme.of(context).colorScheme.onPrimary,
      width: borderWidth ?? 2.0,
    );

    Widget _textInfoWidgetBuilder(surplus) => BorderedCircleAvatar(
          border: border,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '+$surplus',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        );
    final _infoWidgetBuilder = infoWidgetBuilder ?? _textInfoWidgetBuilder;

    return SizedBox(
      height: height,
      width: width,
      child: WidgetStack(
        positions: _settings,
        buildInfoWidget: _infoWidgetBuilder,
        stackedWidgets: avatars
            .map(
              (avatar) => BorderedCircleAvatar(
                border: border,
                backgroundImage: avatar,
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Draws the avatar with border
class BorderedCircleAvatar extends StatelessWidget {
  const BorderedCircleAvatar({
    Key? key,
    this.border = const BorderSide(),
    this.backgroundImage,
    this.backgroundColor,
    this.child,
  }) : super(key: key);

  final BorderSide border;
  final Widget? backgroundImage;
  final Color? backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: border.color,
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Padding(
          padding: EdgeInsets.all(border.width),
          child: CircleAvatar(
            backgroundColor: backgroundColor,
            child: backgroundImage,
          ),
        ),
      ),
    );
  }
}
