// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VisitListState {
  AsyncValue<List<VisitModel>> get allVisits =>
      throw _privateConstructorUsedError;
  List<VisitorStatusModel> get lstStatus => throw _privateConstructorUsedError;
  bool get loadingData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VisitListStateCopyWith<VisitListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitListStateCopyWith<$Res> {
  factory $VisitListStateCopyWith(
          VisitListState value, $Res Function(VisitListState) then) =
      _$VisitListStateCopyWithImpl<$Res, VisitListState>;
  @useResult
  $Res call(
      {AsyncValue<List<VisitModel>> allVisits,
      List<VisitorStatusModel> lstStatus,
      bool loadingData});
}

/// @nodoc
class _$VisitListStateCopyWithImpl<$Res, $Val extends VisitListState>
    implements $VisitListStateCopyWith<$Res> {
  _$VisitListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allVisits = null,
    Object? lstStatus = null,
    Object? loadingData = null,
  }) {
    return _then(_value.copyWith(
      allVisits: null == allVisits
          ? _value.allVisits
          : allVisits // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<VisitModel>>,
      lstStatus: null == lstStatus
          ? _value.lstStatus
          : lstStatus // ignore: cast_nullable_to_non_nullable
              as List<VisitorStatusModel>,
      loadingData: null == loadingData
          ? _value.loadingData
          : loadingData // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VisitListStateCopyWith<$Res>
    implements $VisitListStateCopyWith<$Res> {
  factory _$$_VisitListStateCopyWith(
          _$_VisitListState value, $Res Function(_$_VisitListState) then) =
      __$$_VisitListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<List<VisitModel>> allVisits,
      List<VisitorStatusModel> lstStatus,
      bool loadingData});
}

/// @nodoc
class __$$_VisitListStateCopyWithImpl<$Res>
    extends _$VisitListStateCopyWithImpl<$Res, _$_VisitListState>
    implements _$$_VisitListStateCopyWith<$Res> {
  __$$_VisitListStateCopyWithImpl(
      _$_VisitListState _value, $Res Function(_$_VisitListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allVisits = null,
    Object? lstStatus = null,
    Object? loadingData = null,
  }) {
    return _then(_$_VisitListState(
      allVisits: null == allVisits
          ? _value.allVisits
          : allVisits // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<VisitModel>>,
      lstStatus: null == lstStatus
          ? _value._lstStatus
          : lstStatus // ignore: cast_nullable_to_non_nullable
              as List<VisitorStatusModel>,
      loadingData: null == loadingData
          ? _value.loadingData
          : loadingData // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_VisitListState implements _VisitListState {
  const _$_VisitListState(
      {required this.allVisits,
      required final List<VisitorStatusModel> lstStatus,
      required this.loadingData})
      : _lstStatus = lstStatus;

  @override
  final AsyncValue<List<VisitModel>> allVisits;
  final List<VisitorStatusModel> _lstStatus;
  @override
  List<VisitorStatusModel> get lstStatus {
    if (_lstStatus is EqualUnmodifiableListView) return _lstStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstStatus);
  }

  @override
  final bool loadingData;

  @override
  String toString() {
    return 'VisitListState(allVisits: $allVisits, lstStatus: $lstStatus, loadingData: $loadingData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VisitListState &&
            (identical(other.allVisits, allVisits) ||
                other.allVisits == allVisits) &&
            const DeepCollectionEquality()
                .equals(other._lstStatus, _lstStatus) &&
            (identical(other.loadingData, loadingData) ||
                other.loadingData == loadingData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, allVisits,
      const DeepCollectionEquality().hash(_lstStatus), loadingData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VisitListStateCopyWith<_$_VisitListState> get copyWith =>
      __$$_VisitListStateCopyWithImpl<_$_VisitListState>(this, _$identity);
}

abstract class _VisitListState implements VisitListState {
  const factory _VisitListState(
      {required final AsyncValue<List<VisitModel>> allVisits,
      required final List<VisitorStatusModel> lstStatus,
      required final bool loadingData}) = _$_VisitListState;

  @override
  AsyncValue<List<VisitModel>> get allVisits;
  @override
  List<VisitorStatusModel> get lstStatus;
  @override
  bool get loadingData;
  @override
  @JsonKey(ignore: true)
  _$$_VisitListStateCopyWith<_$_VisitListState> get copyWith =>
      throw _privateConstructorUsedError;
}
