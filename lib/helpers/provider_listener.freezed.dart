// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_listener.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProviderListener {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(dynamic result, String? error) apiStatus,
    required TResult Function(String msg) error,
    required TResult Function() none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(dynamic result, String? error)? apiStatus,
    TResult? Function(String msg)? error,
    TResult? Function()? none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(dynamic result, String? error)? apiStatus,
    TResult Function(String msg)? error,
    TResult Function()? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_ApiStatus value) apiStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_None value) none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ApiStatus value)? apiStatus,
    TResult? Function(_Error value)? error,
    TResult? Function(_None value)? none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_ApiStatus value)? apiStatus,
    TResult Function(_Error value)? error,
    TResult Function(_None value)? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderListenerCopyWith<$Res> {
  factory $ProviderListenerCopyWith(
          ProviderListener value, $Res Function(ProviderListener) then) =
      _$ProviderListenerCopyWithImpl<$Res, ProviderListener>;
}

/// @nodoc
class _$ProviderListenerCopyWithImpl<$Res, $Val extends ProviderListener>
    implements $ProviderListenerCopyWith<$Res> {
  _$ProviderListenerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_LoadingCopyWith<$Res> {
  factory _$$_LoadingCopyWith(
          _$_Loading value, $Res Function(_$_Loading) then) =
      __$$_LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_LoadingCopyWithImpl<$Res>
    extends _$ProviderListenerCopyWithImpl<$Res, _$_Loading>
    implements _$$_LoadingCopyWith<$Res> {
  __$$_LoadingCopyWithImpl(_$_Loading _value, $Res Function(_$_Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'ProviderListener.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(dynamic result, String? error) apiStatus,
    required TResult Function(String msg) error,
    required TResult Function() none,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(dynamic result, String? error)? apiStatus,
    TResult? Function(String msg)? error,
    TResult? Function()? none,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(dynamic result, String? error)? apiStatus,
    TResult Function(String msg)? error,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_ApiStatus value) apiStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_None value) none,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ApiStatus value)? apiStatus,
    TResult? Function(_Error value)? error,
    TResult? Function(_None value)? none,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_ApiStatus value)? apiStatus,
    TResult Function(_Error value)? error,
    TResult Function(_None value)? none,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ProviderListener {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$$_ApiStatusCopyWith<$Res> {
  factory _$$_ApiStatusCopyWith(
          _$_ApiStatus value, $Res Function(_$_ApiStatus) then) =
      __$$_ApiStatusCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic result, String? error});
}

/// @nodoc
class __$$_ApiStatusCopyWithImpl<$Res>
    extends _$ProviderListenerCopyWithImpl<$Res, _$_ApiStatus>
    implements _$$_ApiStatusCopyWith<$Res> {
  __$$_ApiStatusCopyWithImpl(
      _$_ApiStatus _value, $Res Function(_$_ApiStatus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(_$_ApiStatus(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as dynamic,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ApiStatus implements _ApiStatus {
  const _$_ApiStatus({this.result, this.error});

  @override
  final dynamic result;
  @override
  final String? error;

  @override
  String toString() {
    return 'ProviderListener.apiStatus(result: $result, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiStatus &&
            const DeepCollectionEquality().equals(other.result, result) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(result), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApiStatusCopyWith<_$_ApiStatus> get copyWith =>
      __$$_ApiStatusCopyWithImpl<_$_ApiStatus>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(dynamic result, String? error) apiStatus,
    required TResult Function(String msg) error,
    required TResult Function() none,
  }) {
    return apiStatus(result, this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(dynamic result, String? error)? apiStatus,
    TResult? Function(String msg)? error,
    TResult? Function()? none,
  }) {
    return apiStatus?.call(result, this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(dynamic result, String? error)? apiStatus,
    TResult Function(String msg)? error,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (apiStatus != null) {
      return apiStatus(result, this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_ApiStatus value) apiStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_None value) none,
  }) {
    return apiStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ApiStatus value)? apiStatus,
    TResult? Function(_Error value)? error,
    TResult? Function(_None value)? none,
  }) {
    return apiStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_ApiStatus value)? apiStatus,
    TResult Function(_Error value)? error,
    TResult Function(_None value)? none,
    required TResult orElse(),
  }) {
    if (apiStatus != null) {
      return apiStatus(this);
    }
    return orElse();
  }
}

abstract class _ApiStatus implements ProviderListener {
  const factory _ApiStatus({final dynamic result, final String? error}) =
      _$_ApiStatus;

  dynamic get result;
  String? get error;
  @JsonKey(ignore: true)
  _$$_ApiStatusCopyWith<_$_ApiStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorCopyWith<$Res> {
  factory _$$_ErrorCopyWith(_$_Error value, $Res Function(_$_Error) then) =
      __$$_ErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$_ErrorCopyWithImpl<$Res>
    extends _$ProviderListenerCopyWithImpl<$Res, _$_Error>
    implements _$$_ErrorCopyWith<$Res> {
  __$$_ErrorCopyWithImpl(_$_Error _value, $Res Function(_$_Error) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$_Error(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error({required this.msg});

  @override
  final String msg;

  @override
  String toString() {
    return 'ProviderListener.error(msg: $msg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Error &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      __$$_ErrorCopyWithImpl<_$_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(dynamic result, String? error) apiStatus,
    required TResult Function(String msg) error,
    required TResult Function() none,
  }) {
    return error(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(dynamic result, String? error)? apiStatus,
    TResult? Function(String msg)? error,
    TResult? Function()? none,
  }) {
    return error?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(dynamic result, String? error)? apiStatus,
    TResult Function(String msg)? error,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_ApiStatus value) apiStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_None value) none,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ApiStatus value)? apiStatus,
    TResult? Function(_Error value)? error,
    TResult? Function(_None value)? none,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_ApiStatus value)? apiStatus,
    TResult Function(_Error value)? error,
    TResult Function(_None value)? none,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ProviderListener {
  const factory _Error({required final String msg}) = _$_Error;

  String get msg;
  @JsonKey(ignore: true)
  _$$_ErrorCopyWith<_$_Error> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_NoneCopyWith<$Res> {
  factory _$$_NoneCopyWith(_$_None value, $Res Function(_$_None) then) =
      __$$_NoneCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_NoneCopyWithImpl<$Res>
    extends _$ProviderListenerCopyWithImpl<$Res, _$_None>
    implements _$$_NoneCopyWith<$Res> {
  __$$_NoneCopyWithImpl(_$_None _value, $Res Function(_$_None) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_None implements _None {
  const _$_None();

  @override
  String toString() {
    return 'ProviderListener.none()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_None);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(dynamic result, String? error) apiStatus,
    required TResult Function(String msg) error,
    required TResult Function() none,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(dynamic result, String? error)? apiStatus,
    TResult? Function(String msg)? error,
    TResult? Function()? none,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(dynamic result, String? error)? apiStatus,
    TResult Function(String msg)? error,
    TResult Function()? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_ApiStatus value) apiStatus,
    required TResult Function(_Error value) error,
    required TResult Function(_None value) none,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ApiStatus value)? apiStatus,
    TResult? Function(_Error value)? error,
    TResult? Function(_None value)? none,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_ApiStatus value)? apiStatus,
    TResult Function(_Error value)? error,
    TResult Function(_None value)? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class _None implements ProviderListener {
  const factory _None() = _$_None;
}
