// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space_booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpaceBookingState {
  AsyncValue<List<RoomModel>> get lstData => throw _privateConstructorUsedError;
  AsyncValue<List<RoomModel>> get lstDataSearch =>
      throw _privateConstructorUsedError;
  FilterModel? get filterData => throw _privateConstructorUsedError;
  String? get filterDataString => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpaceBookingStateCopyWith<SpaceBookingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpaceBookingStateCopyWith<$Res> {
  factory $SpaceBookingStateCopyWith(
          SpaceBookingState value, $Res Function(SpaceBookingState) then) =
      _$SpaceBookingStateCopyWithImpl<$Res, SpaceBookingState>;
  @useResult
  $Res call(
      {AsyncValue<List<RoomModel>> lstData,
      AsyncValue<List<RoomModel>> lstDataSearch,
      FilterModel? filterData,
      String? filterDataString});
}

/// @nodoc
class _$SpaceBookingStateCopyWithImpl<$Res, $Val extends SpaceBookingState>
    implements $SpaceBookingStateCopyWith<$Res> {
  _$SpaceBookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstData = null,
    Object? lstDataSearch = null,
    Object? filterData = freezed,
    Object? filterDataString = freezed,
  }) {
    return _then(_value.copyWith(
      lstData: null == lstData
          ? _value.lstData
          : lstData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<RoomModel>>,
      lstDataSearch: null == lstDataSearch
          ? _value.lstDataSearch
          : lstDataSearch // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<RoomModel>>,
      filterData: freezed == filterData
          ? _value.filterData
          : filterData // ignore: cast_nullable_to_non_nullable
              as FilterModel?,
      filterDataString: freezed == filterDataString
          ? _value.filterDataString
          : filterDataString // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpaceBookingStateCopyWith<$Res>
    implements $SpaceBookingStateCopyWith<$Res> {
  factory _$$_SpaceBookingStateCopyWith(_$_SpaceBookingState value,
          $Res Function(_$_SpaceBookingState) then) =
      __$$_SpaceBookingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<List<RoomModel>> lstData,
      AsyncValue<List<RoomModel>> lstDataSearch,
      FilterModel? filterData,
      String? filterDataString});
}

/// @nodoc
class __$$_SpaceBookingStateCopyWithImpl<$Res>
    extends _$SpaceBookingStateCopyWithImpl<$Res, _$_SpaceBookingState>
    implements _$$_SpaceBookingStateCopyWith<$Res> {
  __$$_SpaceBookingStateCopyWithImpl(
      _$_SpaceBookingState _value, $Res Function(_$_SpaceBookingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstData = null,
    Object? lstDataSearch = null,
    Object? filterData = freezed,
    Object? filterDataString = freezed,
  }) {
    return _then(_$_SpaceBookingState(
      lstData: null == lstData
          ? _value.lstData
          : lstData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<RoomModel>>,
      lstDataSearch: null == lstDataSearch
          ? _value.lstDataSearch
          : lstDataSearch // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<RoomModel>>,
      filterData: freezed == filterData
          ? _value.filterData
          : filterData // ignore: cast_nullable_to_non_nullable
              as FilterModel?,
      filterDataString: freezed == filterDataString
          ? _value.filterDataString
          : filterDataString // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_SpaceBookingState implements _SpaceBookingState {
  const _$_SpaceBookingState(
      {required this.lstData,
      required this.lstDataSearch,
      this.filterData,
      this.filterDataString});

  @override
  final AsyncValue<List<RoomModel>> lstData;
  @override
  final AsyncValue<List<RoomModel>> lstDataSearch;
  @override
  final FilterModel? filterData;
  @override
  final String? filterDataString;

  @override
  String toString() {
    return 'SpaceBookingState(lstData: $lstData, lstDataSearch: $lstDataSearch, filterData: $filterData, filterDataString: $filterDataString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpaceBookingState &&
            (identical(other.lstData, lstData) || other.lstData == lstData) &&
            (identical(other.lstDataSearch, lstDataSearch) ||
                other.lstDataSearch == lstDataSearch) &&
            (identical(other.filterData, filterData) ||
                other.filterData == filterData) &&
            (identical(other.filterDataString, filterDataString) ||
                other.filterDataString == filterDataString));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, lstData, lstDataSearch, filterData, filterDataString);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpaceBookingStateCopyWith<_$_SpaceBookingState> get copyWith =>
      __$$_SpaceBookingStateCopyWithImpl<_$_SpaceBookingState>(
          this, _$identity);
}

abstract class _SpaceBookingState implements SpaceBookingState {
  const factory _SpaceBookingState(
      {required final AsyncValue<List<RoomModel>> lstData,
      required final AsyncValue<List<RoomModel>> lstDataSearch,
      final FilterModel? filterData,
      final String? filterDataString}) = _$_SpaceBookingState;

  @override
  AsyncValue<List<RoomModel>> get lstData;
  @override
  AsyncValue<List<RoomModel>> get lstDataSearch;
  @override
  FilterModel? get filterData;
  @override
  String? get filterDataString;
  @override
  @JsonKey(ignore: true)
  _$$_SpaceBookingStateCopyWith<_$_SpaceBookingState> get copyWith =>
      throw _privateConstructorUsedError;
}
