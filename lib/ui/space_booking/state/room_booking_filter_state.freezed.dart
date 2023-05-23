// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_booking_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RoomBookingState {
  bool get isOpenDatePicker => throw _privateConstructorUsedError;
  bool get isOpenStartTimePicker => throw _privateConstructorUsedError;
  bool get isOpenEndTimePicker => throw _privateConstructorUsedError;
  String get selectedDateString => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  List<DateTime> get selectedDates => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoomBookingStateCopyWith<RoomBookingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomBookingStateCopyWith<$Res> {
  factory $RoomBookingStateCopyWith(
          RoomBookingState value, $Res Function(RoomBookingState) then) =
      _$RoomBookingStateCopyWithImpl<$Res, RoomBookingState>;
  @useResult
  $Res call(
      {bool isOpenDatePicker,
      bool isOpenStartTimePicker,
      bool isOpenEndTimePicker,
      String selectedDateString,
      DateTime? startTime,
      DateTime? endTime,
      List<DateTime> selectedDates});
}

/// @nodoc
class _$RoomBookingStateCopyWithImpl<$Res, $Val extends RoomBookingState>
    implements $RoomBookingStateCopyWith<$Res> {
  _$RoomBookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isOpenDatePicker = null,
    Object? isOpenStartTimePicker = null,
    Object? isOpenEndTimePicker = null,
    Object? selectedDateString = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? selectedDates = null,
  }) {
    return _then(_value.copyWith(
      isOpenDatePicker: null == isOpenDatePicker
          ? _value.isOpenDatePicker
          : isOpenDatePicker // ignore: cast_nullable_to_non_nullable
              as bool,
      isOpenStartTimePicker: null == isOpenStartTimePicker
          ? _value.isOpenStartTimePicker
          : isOpenStartTimePicker // ignore: cast_nullable_to_non_nullable
              as bool,
      isOpenEndTimePicker: null == isOpenEndTimePicker
          ? _value.isOpenEndTimePicker
          : isOpenEndTimePicker // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedDateString: null == selectedDateString
          ? _value.selectedDateString
          : selectedDateString // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedDates: null == selectedDates
          ? _value.selectedDates
          : selectedDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoomBookingStateCopyWith<$Res>
    implements $RoomBookingStateCopyWith<$Res> {
  factory _$$_RoomBookingStateCopyWith(
          _$_RoomBookingState value, $Res Function(_$_RoomBookingState) then) =
      __$$_RoomBookingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isOpenDatePicker,
      bool isOpenStartTimePicker,
      bool isOpenEndTimePicker,
      String selectedDateString,
      DateTime? startTime,
      DateTime? endTime,
      List<DateTime> selectedDates});
}

/// @nodoc
class __$$_RoomBookingStateCopyWithImpl<$Res>
    extends _$RoomBookingStateCopyWithImpl<$Res, _$_RoomBookingState>
    implements _$$_RoomBookingStateCopyWith<$Res> {
  __$$_RoomBookingStateCopyWithImpl(
      _$_RoomBookingState _value, $Res Function(_$_RoomBookingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isOpenDatePicker = null,
    Object? isOpenStartTimePicker = null,
    Object? isOpenEndTimePicker = null,
    Object? selectedDateString = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? selectedDates = null,
  }) {
    return _then(_$_RoomBookingState(
      isOpenDatePicker: null == isOpenDatePicker
          ? _value.isOpenDatePicker
          : isOpenDatePicker // ignore: cast_nullable_to_non_nullable
              as bool,
      isOpenStartTimePicker: null == isOpenStartTimePicker
          ? _value.isOpenStartTimePicker
          : isOpenStartTimePicker // ignore: cast_nullable_to_non_nullable
              as bool,
      isOpenEndTimePicker: null == isOpenEndTimePicker
          ? _value.isOpenEndTimePicker
          : isOpenEndTimePicker // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedDateString: null == selectedDateString
          ? _value.selectedDateString
          : selectedDateString // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedDates: null == selectedDates
          ? _value._selectedDates
          : selectedDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ));
  }
}

/// @nodoc

class _$_RoomBookingState implements _RoomBookingState {
  const _$_RoomBookingState(
      {required this.isOpenDatePicker,
      required this.isOpenStartTimePicker,
      required this.isOpenEndTimePicker,
      required this.selectedDateString,
      required this.startTime,
      required this.endTime,
      required final List<DateTime> selectedDates})
      : _selectedDates = selectedDates;

  @override
  final bool isOpenDatePicker;
  @override
  final bool isOpenStartTimePicker;
  @override
  final bool isOpenEndTimePicker;
  @override
  final String selectedDateString;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  final List<DateTime> _selectedDates;
  @override
  List<DateTime> get selectedDates {
    if (_selectedDates is EqualUnmodifiableListView) return _selectedDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedDates);
  }

  @override
  String toString() {
    return 'RoomBookingState(isOpenDatePicker: $isOpenDatePicker, isOpenStartTimePicker: $isOpenStartTimePicker, isOpenEndTimePicker: $isOpenEndTimePicker, selectedDateString: $selectedDateString, startTime: $startTime, endTime: $endTime, selectedDates: $selectedDates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoomBookingState &&
            (identical(other.isOpenDatePicker, isOpenDatePicker) ||
                other.isOpenDatePicker == isOpenDatePicker) &&
            (identical(other.isOpenStartTimePicker, isOpenStartTimePicker) ||
                other.isOpenStartTimePicker == isOpenStartTimePicker) &&
            (identical(other.isOpenEndTimePicker, isOpenEndTimePicker) ||
                other.isOpenEndTimePicker == isOpenEndTimePicker) &&
            (identical(other.selectedDateString, selectedDateString) ||
                other.selectedDateString == selectedDateString) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            const DeepCollectionEquality()
                .equals(other._selectedDates, _selectedDates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isOpenDatePicker,
      isOpenStartTimePicker,
      isOpenEndTimePicker,
      selectedDateString,
      startTime,
      endTime,
      const DeepCollectionEquality().hash(_selectedDates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoomBookingStateCopyWith<_$_RoomBookingState> get copyWith =>
      __$$_RoomBookingStateCopyWithImpl<_$_RoomBookingState>(this, _$identity);
}

abstract class _RoomBookingState implements RoomBookingState {
  const factory _RoomBookingState(
      {required final bool isOpenDatePicker,
      required final bool isOpenStartTimePicker,
      required final bool isOpenEndTimePicker,
      required final String selectedDateString,
      required final DateTime? startTime,
      required final DateTime? endTime,
      required final List<DateTime> selectedDates}) = _$_RoomBookingState;

  @override
  bool get isOpenDatePicker;
  @override
  bool get isOpenStartTimePicker;
  @override
  bool get isOpenEndTimePicker;
  @override
  String get selectedDateString;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;
  @override
  List<DateTime> get selectedDates;
  @override
  @JsonKey(ignore: true)
  _$$_RoomBookingStateCopyWith<_$_RoomBookingState> get copyWith =>
      throw _privateConstructorUsedError;
}
