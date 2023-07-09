import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/home/model/category_model.dart';

part 'home_states.freezed.dart';

@freezed
class HomeStates with _$HomeStates {
  const factory HomeStates({
    required List<CategoryModel> lstCategory,
  }) = _HomeStates;

  factory HomeStates.initial() => const HomeStates(lstCategory: <CategoryModel>[]);
}
