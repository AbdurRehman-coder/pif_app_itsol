// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_booking_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ScanBookingListState {
  AsyncValue<List<RoomModel>> get lstData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScanBookingListStateCopyWith<ScanBookingListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanBookingListStateCopyWith<$Res> {
  factory $ScanBookingListStateCopyWith(ScanBookingListState value,
          $Res Function(ScanBookingListState) then) =
      _$ScanBookingListStateCopyWithImpl<$Res, ScanBookingListState>;
  @useResult
  $Res call({AsyncValue<List<RoomModel>> lstData});
}

/// @nodoc
class _$ScanBookingListStateCopyWithImpl<$Res,
        $Val extends ScanBookingListState>
    implements $ScanBookingListStateCopyWith<$Res> {
  _$ScanBookingListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstData = null,
  }) {
    return _then(_value.copyWith(
      lstData: null == lstData
          ? _value.lstData
          : lstData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<RoomModel>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScanBookingListStateCopyWith<$Res>
    implements $ScanBookingListStateCopyWith<$Res> {
  factory _$$_ScanBookingListStateCopyWith(_$_ScanBookingListState value,
          $Res Function(_$_ScanBookingListState) then) =
      __$$_ScanBookingListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<RoomModel>> lstData});
}

/// @nodoc
class __$$_ScanBookingListStateCopyWithImpl<$Res>
    extends _$ScanBookingListStateCopyWithImpl<$Res, _$_ScanBookingListState>
    implements _$$_ScanBookingListStateCopyWith<$Res> {
  __$$_ScanBookingListStateCopyWithImpl(_$_ScanBookingListState _value,
      $Res Function(_$_ScanBookingListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstData = null,
  }) {
    return _then(_$_ScanBookingListState(
      lstData: null == lstData
          ? _value.lstData
          : lstData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<RoomModel>>,
    ));
  }
}

/// @nodoc

class _$_ScanBookingListState implements _ScanBookingListState {
  const _$_ScanBookingListState({required this.lstData});

  @override
  final AsyncValue<List<RoomModel>> lstData;

  @override
  String toString() {
    return 'ScanBookingListState(lstData: $lstData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScanBookingListState &&
            (identical(other.lstData, lstData) || other.lstData == lstData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lstData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScanBookingListStateCopyWith<_$_ScanBookingListState> get copyWith =>
      __$$_ScanBookingListStateCopyWithImpl<_$_ScanBookingListState>(
          this, _$identity);
}

abstract class _ScanBookingListState implements ScanBookingListState {
  const factory _ScanBookingListState(
          {required final AsyncValue<List<RoomModel>> lstData}) =
      _$_ScanBookingListState;

  @override
  AsyncValue<List<RoomModel>> get lstData;
  @override
  @JsonKey(ignore: true)
  _$$_ScanBookingListStateCopyWith<_$_ScanBookingListState> get copyWith =>
      throw _privateConstructorUsedError;
}
