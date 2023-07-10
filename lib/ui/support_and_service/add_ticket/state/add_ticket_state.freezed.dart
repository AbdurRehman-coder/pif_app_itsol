// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_ticket_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddOrEditTicketState {
  XFile? get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddOrEditTicketStateCopyWith<AddOrEditTicketState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddOrEditTicketStateCopyWith<$Res> {
  factory $AddOrEditTicketStateCopyWith(AddOrEditTicketState value,
          $Res Function(AddOrEditTicketState) then) =
      _$AddOrEditTicketStateCopyWithImpl<$Res, AddOrEditTicketState>;
  @useResult
  $Res call({XFile? image});
}

/// @nodoc
class _$AddOrEditTicketStateCopyWithImpl<$Res,
        $Val extends AddOrEditTicketState>
    implements $AddOrEditTicketStateCopyWith<$Res> {
  _$AddOrEditTicketStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddOrEditTicketStateCopyWith<$Res>
    implements $AddOrEditTicketStateCopyWith<$Res> {
  factory _$$_AddOrEditTicketStateCopyWith(_$_AddOrEditTicketState value,
          $Res Function(_$_AddOrEditTicketState) then) =
      __$$_AddOrEditTicketStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({XFile? image});
}

/// @nodoc
class __$$_AddOrEditTicketStateCopyWithImpl<$Res>
    extends _$AddOrEditTicketStateCopyWithImpl<$Res, _$_AddOrEditTicketState>
    implements _$$_AddOrEditTicketStateCopyWith<$Res> {
  __$$_AddOrEditTicketStateCopyWithImpl(_$_AddOrEditTicketState _value,
      $Res Function(_$_AddOrEditTicketState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
  }) {
    return _then(_$_AddOrEditTicketState(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as XFile?,
    ));
  }
}

/// @nodoc

class _$_AddOrEditTicketState implements _AddOrEditTicketState {
  const _$_AddOrEditTicketState({required this.image});

  @override
  final XFile? image;

  @override
  String toString() {
    return 'AddOrEditTicketState(image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddOrEditTicketState &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddOrEditTicketStateCopyWith<_$_AddOrEditTicketState> get copyWith =>
      __$$_AddOrEditTicketStateCopyWithImpl<_$_AddOrEditTicketState>(
          this, _$identity);
}

abstract class _AddOrEditTicketState implements AddOrEditTicketState {
  const factory _AddOrEditTicketState({required final XFile? image}) =
      _$_AddOrEditTicketState;

  @override
  XFile? get image;
  @override
  @JsonKey(ignore: true)
  _$$_AddOrEditTicketStateCopyWith<_$_AddOrEditTicketState> get copyWith =>
      throw _privateConstructorUsedError;
}
