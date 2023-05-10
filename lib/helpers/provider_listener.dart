import 'package:freezed_annotation/freezed_annotation.dart';

part 'provider_listener.freezed.dart';

@freezed
class ProviderListener with _$ProviderListener {
  const factory ProviderListener.loading() = _Loading;

  const factory ProviderListener.apiStatus({dynamic result, String? error}) = _ApiStatus;

  const factory ProviderListener.error({required String msg}) = _Error;

  const factory ProviderListener.none() = _None;
}
