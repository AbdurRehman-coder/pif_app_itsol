// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_scanner_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BookScannerState {
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BookScannerStateCopyWith<BookScannerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookScannerStateCopyWith<$Res> {
  factory $BookScannerStateCopyWith(
          BookScannerState value, $Res Function(BookScannerState) then) =
      _$BookScannerStateCopyWithImpl<$Res, BookScannerState>;
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class _$BookScannerStateCopyWithImpl<$Res, $Val extends BookScannerState>
    implements $BookScannerStateCopyWith<$Res> {
  _$BookScannerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookScannerStateCopyWith<$Res>
    implements $BookScannerStateCopyWith<$Res> {
  factory _$$_BookScannerStateCopyWith(
          _$_BookScannerState value, $Res Function(_$_BookScannerState) then) =
      __$$_BookScannerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading});
}

/// @nodoc
class __$$_BookScannerStateCopyWithImpl<$Res>
    extends _$BookScannerStateCopyWithImpl<$Res, _$_BookScannerState>
    implements _$$_BookScannerStateCopyWith<$Res> {
  __$$_BookScannerStateCopyWithImpl(
      _$_BookScannerState _value, $Res Function(_$_BookScannerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
  }) {
    return _then(_$_BookScannerState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BookScannerState implements _BookScannerState {
  const _$_BookScannerState({required this.isLoading});

  @override
  final bool isLoading;

  @override
  String toString() {
    return 'BookScannerState(isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookScannerState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookScannerStateCopyWith<_$_BookScannerState> get copyWith =>
      __$$_BookScannerStateCopyWithImpl<_$_BookScannerState>(this, _$identity);
}

abstract class _BookScannerState implements BookScannerState {
  const factory _BookScannerState({required final bool isLoading}) =
      _$_BookScannerState;

  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_BookScannerStateCopyWith<_$_BookScannerState> get copyWith =>
      throw _privateConstructorUsedError;
}
