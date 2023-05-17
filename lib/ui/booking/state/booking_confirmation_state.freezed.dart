// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_confirmation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BookingConfirmationState {
  int get sliderValue => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookingConfirmationStateCopyWith<BookingConfirmationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingConfirmationStateCopyWith<$Res> {
  factory $BookingConfirmationStateCopyWith(BookingConfirmationState value,
          $Res Function(BookingConfirmationState) then) =
      _$BookingConfirmationStateCopyWithImpl<$Res, BookingConfirmationState>;
  @useResult
  $Res call({int sliderValue});
}

/// @nodoc
class _$BookingConfirmationStateCopyWithImpl<$Res,
        $Val extends BookingConfirmationState>
    implements $BookingConfirmationStateCopyWith<$Res> {
  _$BookingConfirmationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sliderValue = null,
  }) {
    return _then(_value.copyWith(
      sliderValue: null == sliderValue
          ? _value.sliderValue
          : sliderValue // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookingConfirmationStateCopyWith<$Res>
    implements $BookingConfirmationStateCopyWith<$Res> {
  factory _$$_BookingConfirmationStateCopyWith(
          _$_BookingConfirmationState value,
          $Res Function(_$_BookingConfirmationState) then) =
      __$$_BookingConfirmationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int sliderValue});
}

/// @nodoc
class __$$_BookingConfirmationStateCopyWithImpl<$Res>
    extends _$BookingConfirmationStateCopyWithImpl<$Res,
        _$_BookingConfirmationState>
    implements _$$_BookingConfirmationStateCopyWith<$Res> {
  __$$_BookingConfirmationStateCopyWithImpl(_$_BookingConfirmationState _value,
      $Res Function(_$_BookingConfirmationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sliderValue = null,
  }) {
    return _then(_$_BookingConfirmationState(
      sliderValue: null == sliderValue
          ? _value.sliderValue
          : sliderValue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_BookingConfirmationState implements _BookingConfirmationState {
  const _$_BookingConfirmationState({required this.sliderValue});

  @override
  final int sliderValue;

  @override
  String toString() {
    return 'BookingConfirmationState(sliderValue: $sliderValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookingConfirmationState &&
            (identical(other.sliderValue, sliderValue) ||
                other.sliderValue == sliderValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sliderValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookingConfirmationStateCopyWith<_$_BookingConfirmationState>
      get copyWith => __$$_BookingConfirmationStateCopyWithImpl<
          _$_BookingConfirmationState>(this, _$identity);
}

abstract class _BookingConfirmationState implements BookingConfirmationState {
  const factory _BookingConfirmationState({required final int sliderValue}) =
      _$_BookingConfirmationState;

  @override
  int get sliderValue;
  @override
  @JsonKey(ignore: true)
  _$$_BookingConfirmationStateCopyWith<_$_BookingConfirmationState>
      get copyWith => throw _privateConstructorUsedError;
}
