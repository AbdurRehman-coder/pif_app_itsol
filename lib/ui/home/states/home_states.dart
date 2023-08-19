import 'package:dixels_sdk/features/content/cards/model/cards_model.dart';
import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/home/model/category_model.dart';

part 'home_states.freezed.dart';

@freezed
class HomeStates with _$HomeStates {
  const factory HomeStates({
    required AsyncValue<List<StructureContentModel>> newsList,
    required int weatherDegree,
    required AsyncValue<List<StructureContentModel>> servicesList,
    required AsyncValue<List<Widget>> cardList,
    required AsyncValue<CardsModel> cardsData,
  }) = _HomeStates;

  factory HomeStates.initial() => const HomeStates(
        newsList: AsyncLoading(),
        servicesList: AsyncLoading(),
        weatherDegree: 40,
        cardList: AsyncLoading(),
        cardsData: AsyncLoading(),
      );
}
