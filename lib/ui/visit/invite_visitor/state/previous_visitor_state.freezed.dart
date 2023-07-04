// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'previous_visitor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PreviousVisitorState {
  List<InviteVisitorModel> get previousVisitorList =>
      throw _privateConstructorUsedError;
  bool get isVisibleCancel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PreviousVisitorStateCopyWith<PreviousVisitorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreviousVisitorStateCopyWith<$Res> {
  factory $PreviousVisitorStateCopyWith(PreviousVisitorState value,
          $Res Function(PreviousVisitorState) then) =
      _$PreviousVisitorStateCopyWithImpl<$Res, PreviousVisitorState>;
  @useResult
  $Res call(
      {List<InviteVisitorModel> previousVisitorList, bool isVisibleCancel});
}

/// @nodoc
class _$PreviousVisitorStateCopyWithImpl<$Res,
        $Val extends PreviousVisitorState>
    implements $PreviousVisitorStateCopyWith<$Res> {
  _$PreviousVisitorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousVisitorList = null,
    Object? isVisibleCancel = null,
  }) {
    return _then(_value.copyWith(
      previousVisitorList: null == previousVisitorList
          ? _value.previousVisitorList
          : previousVisitorList // ignore: cast_nullable_to_non_nullable
              as List<InviteVisitorModel>,
      isVisibleCancel: null == isVisibleCancel
          ? _value.isVisibleCancel
          : isVisibleCancel // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PreviousVisitorStateCopyWith<$Res>
    implements $PreviousVisitorStateCopyWith<$Res> {
  factory _$$_PreviousVisitorStateCopyWith(_$_PreviousVisitorState value,
          $Res Function(_$_PreviousVisitorState) then) =
      __$$_PreviousVisitorStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<InviteVisitorModel> previousVisitorList, bool isVisibleCancel});
}

/// @nodoc
class __$$_PreviousVisitorStateCopyWithImpl<$Res>
    extends _$PreviousVisitorStateCopyWithImpl<$Res, _$_PreviousVisitorState>
    implements _$$_PreviousVisitorStateCopyWith<$Res> {
  __$$_PreviousVisitorStateCopyWithImpl(_$_PreviousVisitorState _value,
      $Res Function(_$_PreviousVisitorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousVisitorList = null,
    Object? isVisibleCancel = null,
  }) {
    return _then(_$_PreviousVisitorState(
      previousVisitorList: null == previousVisitorList
          ? _value._previousVisitorList
          : previousVisitorList // ignore: cast_nullable_to_non_nullable
              as List<InviteVisitorModel>,
      isVisibleCancel: null == isVisibleCancel
          ? _value.isVisibleCancel
          : isVisibleCancel // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PreviousVisitorState implements _PreviousVisitorState {
  const _$_PreviousVisitorState(
      {required final List<InviteVisitorModel> previousVisitorList,
      required this.isVisibleCancel})
      : _previousVisitorList = previousVisitorList;

  final List<InviteVisitorModel> _previousVisitorList;
  @override
  List<InviteVisitorModel> get previousVisitorList {
    if (_previousVisitorList is EqualUnmodifiableListView)
      return _previousVisitorList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousVisitorList);
  }

  @override
  final bool isVisibleCancel;

  @override
  String toString() {
    return 'PreviousVisitorState(previousVisitorList: $previousVisitorList, isVisibleCancel: $isVisibleCancel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PreviousVisitorState &&
            const DeepCollectionEquality()
                .equals(other._previousVisitorList, _previousVisitorList) &&
            (identical(other.isVisibleCancel, isVisibleCancel) ||
                other.isVisibleCancel == isVisibleCancel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_previousVisitorList),
      isVisibleCancel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PreviousVisitorStateCopyWith<_$_PreviousVisitorState> get copyWith =>
      __$$_PreviousVisitorStateCopyWithImpl<_$_PreviousVisitorState>(
          this, _$identity);
}

abstract class _PreviousVisitorState implements PreviousVisitorState {
  const factory _PreviousVisitorState(
      {required final List<InviteVisitorModel> previousVisitorList,
      required final bool isVisibleCancel}) = _$_PreviousVisitorState;

  @override
  List<InviteVisitorModel> get previousVisitorList;
  @override
  bool get isVisibleCancel;
  @override
  @JsonKey(ignore: true)
  _$$_PreviousVisitorStateCopyWith<_$_PreviousVisitorState> get copyWith =>
      throw _privateConstructorUsedError;
}
