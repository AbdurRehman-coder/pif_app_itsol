import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/services/model/service_model.dart';

part 'service_state.freezed.dart';

@freezed
class ServiceState with _$ServiceState {
  const factory ServiceState({
    required List<CategoryModel> lstCategory,
    required List<ServiceModel> lstService,
    required bool isFundamental,
    required bool isCreative,
    required bool isCanceled,
  }) = _ServiceState;

  factory ServiceState.initial() => const ServiceState(
        lstCategory: <CategoryModel>[],
        lstService: <ServiceModel>[],
        isCanceled: false,
        isCreative: false,
        isFundamental: false,
      );
}
