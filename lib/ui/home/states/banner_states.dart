import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/home/model/banner_model.dart';

part 'banner_states.freezed.dart';

@freezed
class BannerStates with _$BannerStates {
  const factory BannerStates({
    required List<BannerModel> listBannerModel,
  }) = _BannerStates;

  factory BannerStates.initial() => const BannerStates(listBannerModel: <BannerModel>[]);
}
