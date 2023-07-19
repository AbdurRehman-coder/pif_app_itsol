// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_tickets_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MyTicketsState {
  StatusModel? get selectedStatus => throw _privateConstructorUsedError;
  AsyncValue<List<SupportTicketModel>> get lstData =>
      throw _privateConstructorUsedError;
  List<StatusModel> get lstStatus => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyTicketsStateCopyWith<MyTicketsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyTicketsStateCopyWith<$Res> {
  factory $MyTicketsStateCopyWith(
          MyTicketsState value, $Res Function(MyTicketsState) then) =
      _$MyTicketsStateCopyWithImpl<$Res, MyTicketsState>;
  @useResult
  $Res call(
      {StatusModel? selectedStatus,
      AsyncValue<List<SupportTicketModel>> lstData,
      List<StatusModel> lstStatus,
      bool isLoading});
}

/// @nodoc
class _$MyTicketsStateCopyWithImpl<$Res, $Val extends MyTicketsState>
    implements $MyTicketsStateCopyWith<$Res> {
  _$MyTicketsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedStatus = freezed,
    Object? lstData = null,
    Object? lstStatus = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      selectedStatus: freezed == selectedStatus
          ? _value.selectedStatus
          : selectedStatus // ignore: cast_nullable_to_non_nullable
              as StatusModel?,
      lstData: null == lstData
          ? _value.lstData
          : lstData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SupportTicketModel>>,
      lstStatus: null == lstStatus
          ? _value.lstStatus
          : lstStatus // ignore: cast_nullable_to_non_nullable
              as List<StatusModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyTicketsStateCopyWith<$Res>
    implements $MyTicketsStateCopyWith<$Res> {
  factory _$$_MyTicketsStateCopyWith(
          _$_MyTicketsState value, $Res Function(_$_MyTicketsState) then) =
      __$$_MyTicketsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StatusModel? selectedStatus,
      AsyncValue<List<SupportTicketModel>> lstData,
      List<StatusModel> lstStatus,
      bool isLoading});
}

/// @nodoc
class __$$_MyTicketsStateCopyWithImpl<$Res>
    extends _$MyTicketsStateCopyWithImpl<$Res, _$_MyTicketsState>
    implements _$$_MyTicketsStateCopyWith<$Res> {
  __$$_MyTicketsStateCopyWithImpl(
      _$_MyTicketsState _value, $Res Function(_$_MyTicketsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedStatus = freezed,
    Object? lstData = null,
    Object? lstStatus = null,
    Object? isLoading = null,
  }) {
    return _then(_$_MyTicketsState(
      selectedStatus: freezed == selectedStatus
          ? _value.selectedStatus
          : selectedStatus // ignore: cast_nullable_to_non_nullable
              as StatusModel?,
      lstData: null == lstData
          ? _value.lstData
          : lstData // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SupportTicketModel>>,
      lstStatus: null == lstStatus
          ? _value._lstStatus
          : lstStatus // ignore: cast_nullable_to_non_nullable
              as List<StatusModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_MyTicketsState implements _MyTicketsState {
  const _$_MyTicketsState(
      {required this.selectedStatus,
      required this.lstData,
      required final List<StatusModel> lstStatus,
      required this.isLoading})
      : _lstStatus = lstStatus;

  @override
  final StatusModel? selectedStatus;
  @override
  final AsyncValue<List<SupportTicketModel>> lstData;
  final List<StatusModel> _lstStatus;
  @override
  List<StatusModel> get lstStatus {
    if (_lstStatus is EqualUnmodifiableListView) return _lstStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstStatus);
  }

  @override
  final bool isLoading;

  @override
  String toString() {
    return 'MyTicketsState(selectedStatus: $selectedStatus, lstData: $lstData, lstStatus: $lstStatus, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyTicketsState &&
            (identical(other.selectedStatus, selectedStatus) ||
                other.selectedStatus == selectedStatus) &&
            (identical(other.lstData, lstData) || other.lstData == lstData) &&
            const DeepCollectionEquality()
                .equals(other._lstStatus, _lstStatus) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedStatus, lstData,
      const DeepCollectionEquality().hash(_lstStatus), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyTicketsStateCopyWith<_$_MyTicketsState> get copyWith =>
      __$$_MyTicketsStateCopyWithImpl<_$_MyTicketsState>(this, _$identity);
}

abstract class _MyTicketsState implements MyTicketsState {
  const factory _MyTicketsState(
      {required final StatusModel? selectedStatus,
      required final AsyncValue<List<SupportTicketModel>> lstData,
      required final List<StatusModel> lstStatus,
      required final bool isLoading}) = _$_MyTicketsState;

  @override
  StatusModel? get selectedStatus;
  @override
  AsyncValue<List<SupportTicketModel>> get lstData;
  @override
  List<StatusModel> get lstStatus;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_MyTicketsStateCopyWith<_$_MyTicketsState> get copyWith =>
      throw _privateConstructorUsedError;
}
