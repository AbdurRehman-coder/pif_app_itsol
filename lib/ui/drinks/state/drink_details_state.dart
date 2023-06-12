import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/drinks/index.dart';

part 'drink_details_state.freezed.dart';

@freezed
class DrinkDetailsState with _$DrinkDetailsState {
  const factory DrinkDetailsState({
    required DrinkModel? item,
  }) = _DrinkDetailsState;

  factory DrinkDetailsState.initial() => DrinkDetailsState(
        item: DrinkModel(),
      );
}
