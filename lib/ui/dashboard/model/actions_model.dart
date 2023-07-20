class ActionModel {
  ActionModel({
    required this.actionImage,
    required this.actionFunction,
  });

  final String actionImage;
  final void Function()?  actionFunction;
}
