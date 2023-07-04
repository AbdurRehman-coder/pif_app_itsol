// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_visitor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddVisitorState {
  bool get isFocusFirstName => throw _privateConstructorUsedError;
  bool get isFocusLastName => throw _privateConstructorUsedError;
  bool get isFocusEmail => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddVisitorStateCopyWith<AddVisitorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddVisitorStateCopyWith<$Res> {
  factory $AddVisitorStateCopyWith(
          AddVisitorState value, $Res Function(AddVisitorState) then) =
      _$AddVisitorStateCopyWithImpl<$Res, AddVisitorState>;
  @useResult
  $Res call({bool isFocusFirstName, bool isFocusLastName, bool isFocusEmail});
}

/// @nodoc
class _$AddVisitorStateCopyWithImpl<$Res, $Val extends AddVisitorState>
    implements $AddVisitorStateCopyWith<$Res> {
  _$AddVisitorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFocusFirstName = null,
    Object? isFocusLastName = null,
    Object? isFocusEmail = null,
  }) {
    return _then(_value.copyWith(
      isFocusFirstName: null == isFocusFirstName
          ? _value.isFocusFirstName
          : isFocusFirstName // ignore: cast_nullable_to_non_nullable
              as bool,
      isFocusLastName: null == isFocusLastName
          ? _value.isFocusLastName
          : isFocusLastName // ignore: cast_nullable_to_non_nullable
              as bool,
      isFocusEmail: null == isFocusEmail
          ? _value.isFocusEmail
          : isFocusEmail // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddVisitorStateCopyWith<$Res>
    implements $AddVisitorStateCopyWith<$Res> {
  factory _$$_AddVisitorStateCopyWith(
          _$_AddVisitorState value, $Res Function(_$_AddVisitorState) then) =
      __$$_AddVisitorStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFocusFirstName, bool isFocusLastName, bool isFocusEmail});
}

/// @nodoc
class __$$_AddVisitorStateCopyWithImpl<$Res>
    extends _$AddVisitorStateCopyWithImpl<$Res, _$_AddVisitorState>
    implements _$$_AddVisitorStateCopyWith<$Res> {
  __$$_AddVisitorStateCopyWithImpl(
      _$_AddVisitorState _value, $Res Function(_$_AddVisitorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFocusFirstName = null,
    Object? isFocusLastName = null,
    Object? isFocusEmail = null,
  }) {
    return _then(_$_AddVisitorState(
      isFocusFirstName: null == isFocusFirstName
          ? _value.isFocusFirstName
          : isFocusFirstName // ignore: cast_nullable_to_non_nullable
              as bool,
      isFocusLastName: null == isFocusLastName
          ? _value.isFocusLastName
          : isFocusLastName // ignore: cast_nullable_to_non_nullable
              as bool,
      isFocusEmail: null == isFocusEmail
          ? _value.isFocusEmail
          : isFocusEmail // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AddVisitorState implements _AddVisitorState {
  const _$_AddVisitorState(
      {required this.isFocusFirstName,
      required this.isFocusLastName,
      required this.isFocusEmail});

  @override
  final bool isFocusFirstName;
  @override
  final bool isFocusLastName;
  @override
  final bool isFocusEmail;

  @override
  String toString() {
    return 'AddVisitorState(isFocusFirstName: $isFocusFirstName, isFocusLastName: $isFocusLastName, isFocusEmail: $isFocusEmail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddVisitorState &&
            (identical(other.isFocusFirstName, isFocusFirstName) ||
                other.isFocusFirstName == isFocusFirstName) &&
            (identical(other.isFocusLastName, isFocusLastName) ||
                other.isFocusLastName == isFocusLastName) &&
            (identical(other.isFocusEmail, isFocusEmail) ||
                other.isFocusEmail == isFocusEmail));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isFocusFirstName, isFocusLastName, isFocusEmail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddVisitorStateCopyWith<_$_AddVisitorState> get copyWith =>
      __$$_AddVisitorStateCopyWithImpl<_$_AddVisitorState>(this, _$identity);
}

abstract class _AddVisitorState implements AddVisitorState {
  const factory _AddVisitorState(
      {required final bool isFocusFirstName,
      required final bool isFocusLastName,
      required final bool isFocusEmail}) = _$_AddVisitorState;

  @override
  bool get isFocusFirstName;
  @override
  bool get isFocusLastName;
  @override
  bool get isFocusEmail;
  @override
  @JsonKey(ignore: true)
  _$$_AddVisitorStateCopyWith<_$_AddVisitorState> get copyWith =>
      throw _privateConstructorUsedError;
}
