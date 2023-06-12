// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drink_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DrinkDetailsState {
  DrinkModel? get item => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DrinkDetailsStateCopyWith<DrinkDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrinkDetailsStateCopyWith<$Res> {
  factory $DrinkDetailsStateCopyWith(
          DrinkDetailsState value, $Res Function(DrinkDetailsState) then) =
      _$DrinkDetailsStateCopyWithImpl<$Res, DrinkDetailsState>;
  @useResult
  $Res call({DrinkModel? item});
}

/// @nodoc
class _$DrinkDetailsStateCopyWithImpl<$Res, $Val extends DrinkDetailsState>
    implements $DrinkDetailsStateCopyWith<$Res> {
  _$DrinkDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = freezed,
  }) {
    return _then(_value.copyWith(
      item: freezed == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as DrinkModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DrinkDetailsStateCopyWith<$Res>
    implements $DrinkDetailsStateCopyWith<$Res> {
  factory _$$_DrinkDetailsStateCopyWith(_$_DrinkDetailsState value,
          $Res Function(_$_DrinkDetailsState) then) =
      __$$_DrinkDetailsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DrinkModel? item});
}

/// @nodoc
class __$$_DrinkDetailsStateCopyWithImpl<$Res>
    extends _$DrinkDetailsStateCopyWithImpl<$Res, _$_DrinkDetailsState>
    implements _$$_DrinkDetailsStateCopyWith<$Res> {
  __$$_DrinkDetailsStateCopyWithImpl(
      _$_DrinkDetailsState _value, $Res Function(_$_DrinkDetailsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = freezed,
  }) {
    return _then(_$_DrinkDetailsState(
      item: freezed == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as DrinkModel?,
    ));
  }
}

/// @nodoc

class _$_DrinkDetailsState implements _DrinkDetailsState {
  const _$_DrinkDetailsState({required this.item});

  @override
  final DrinkModel? item;

  @override
  String toString() {
    return 'DrinkDetailsState(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DrinkDetailsState &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DrinkDetailsStateCopyWith<_$_DrinkDetailsState> get copyWith =>
      __$$_DrinkDetailsStateCopyWithImpl<_$_DrinkDetailsState>(
          this, _$identity);
}

abstract class _DrinkDetailsState implements DrinkDetailsState {
  const factory _DrinkDetailsState({required final DrinkModel? item}) =
      _$_DrinkDetailsState;

  @override
  DrinkModel? get item;
  @override
  @JsonKey(ignore: true)
  _$$_DrinkDetailsStateCopyWith<_$_DrinkDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}
