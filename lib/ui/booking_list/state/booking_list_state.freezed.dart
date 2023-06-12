// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BookingListState {
  AsyncValue<List<BookingListModel>> get lstData =>
      throw _privateConstructorUsedError;
  List<BookingStatusModel> get lstStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookingListStateCopyWith<BookingListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingListStateCopyWith<$Res> {
  factory $BookingListStateCopyWith(
          BookingListState value, $Res Function(BookingListState) then) =
      _$BookingListStateCopyWithImpl<$Res, BookingListState>;
  @useResult
  $Res call(
      {AsyncValue<List<BookingListModel>> lstData,
      List<BookingStatusModel> lstStatus});
}

/// @nodoc
class _$BookingListStateCopyWithImpl<$Res, $Val extends BookingListState>
    implements $BookingListStateCopyWith<$Res> {
  _$BookingListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstData = null,
    Object? lstStatus = null,
  }) {
    return _then(_value.copyWith(
      lstData: null == lstData
          ? _value.lstData
          : lstData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<BookingListModel>>,
      lstStatus: null == lstStatus
          ? _value.lstStatus
          : lstStatus // ignore: cast_nullable_to_non_nullable
              as List<BookingStatusModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookingListStateCopyWith<$Res>
    implements $BookingListStateCopyWith<$Res> {
  factory _$$_BookingListStateCopyWith(
          _$_BookingListState value, $Res Function(_$_BookingListState) then) =
      __$$_BookingListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<List<BookingListModel>> lstData,
      List<BookingStatusModel> lstStatus});
}

/// @nodoc
class __$$_BookingListStateCopyWithImpl<$Res>
    extends _$BookingListStateCopyWithImpl<$Res, _$_BookingListState>
    implements _$$_BookingListStateCopyWith<$Res> {
  __$$_BookingListStateCopyWithImpl(
      _$_BookingListState _value, $Res Function(_$_BookingListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstData = null,
    Object? lstStatus = null,
  }) {
    return _then(_$_BookingListState(
      lstData: null == lstData
          ? _value.lstData
          : lstData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<BookingListModel>>,
      lstStatus: null == lstStatus
          ? _value._lstStatus
          : lstStatus // ignore: cast_nullable_to_non_nullable
              as List<BookingStatusModel>,
    ));
  }
}

/// @nodoc

class _$_BookingListState implements _BookingListState {
  const _$_BookingListState(
      {required this.lstData,
      required final List<BookingStatusModel> lstStatus})
      : _lstStatus = lstStatus;

  @override
  final AsyncValue<List<BookingListModel>> lstData;
  final List<BookingStatusModel> _lstStatus;
  @override
  List<BookingStatusModel> get lstStatus {
    if (_lstStatus is EqualUnmodifiableListView) return _lstStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstStatus);
  }

  @override
  String toString() {
    return 'BookingListState(lstData: $lstData, lstStatus: $lstStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookingListState &&
            (identical(other.lstData, lstData) || other.lstData == lstData) &&
            const DeepCollectionEquality()
                .equals(other._lstStatus, _lstStatus));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, lstData, const DeepCollectionEquality().hash(_lstStatus));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookingListStateCopyWith<_$_BookingListState> get copyWith =>
      __$$_BookingListStateCopyWithImpl<_$_BookingListState>(this, _$identity);
}

abstract class _BookingListState implements BookingListState {
  const factory _BookingListState(
      {required final AsyncValue<List<BookingListModel>> lstData,
      required final List<BookingStatusModel> lstStatus}) = _$_BookingListState;

  @override
  AsyncValue<List<BookingListModel>> get lstData;
  @override
  List<BookingStatusModel> get lstStatus;
  @override
  @JsonKey(ignore: true)
  _$$_BookingListStateCopyWith<_$_BookingListState> get copyWith =>
      throw _privateConstructorUsedError;
}
