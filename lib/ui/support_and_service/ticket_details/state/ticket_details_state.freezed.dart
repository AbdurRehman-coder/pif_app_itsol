// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TicketDetailsState {
  List<TicketCommentModel> get lstComments =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TicketDetailsStateCopyWith<TicketDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketDetailsStateCopyWith<$Res> {
  factory $TicketDetailsStateCopyWith(
          TicketDetailsState value, $Res Function(TicketDetailsState) then) =
      _$TicketDetailsStateCopyWithImpl<$Res, TicketDetailsState>;
  @useResult
  $Res call({List<TicketCommentModel> lstComments});
}

/// @nodoc
class _$TicketDetailsStateCopyWithImpl<$Res, $Val extends TicketDetailsState>
    implements $TicketDetailsStateCopyWith<$Res> {
  _$TicketDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstComments = null,
  }) {
    return _then(_value.copyWith(
      lstComments: null == lstComments
          ? _value.lstComments
          : lstComments // ignore: cast_nullable_to_non_nullable
              as List<TicketCommentModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SupportDetailsStateCopyWith<$Res>
    implements $TicketDetailsStateCopyWith<$Res> {
  factory _$$_SupportDetailsStateCopyWith(_$_SupportDetailsState value,
          $Res Function(_$_SupportDetailsState) then) =
      __$$_SupportDetailsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TicketCommentModel> lstComments});
}

/// @nodoc
class __$$_SupportDetailsStateCopyWithImpl<$Res>
    extends _$TicketDetailsStateCopyWithImpl<$Res, _$_SupportDetailsState>
    implements _$$_SupportDetailsStateCopyWith<$Res> {
  __$$_SupportDetailsStateCopyWithImpl(_$_SupportDetailsState _value,
      $Res Function(_$_SupportDetailsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstComments = null,
  }) {
    return _then(_$_SupportDetailsState(
      lstComments: null == lstComments
          ? _value._lstComments
          : lstComments // ignore: cast_nullable_to_non_nullable
              as List<TicketCommentModel>,
    ));
  }
}

/// @nodoc

class _$_SupportDetailsState implements _SupportDetailsState {
  const _$_SupportDetailsState(
      {required final List<TicketCommentModel> lstComments})
      : _lstComments = lstComments;

  final List<TicketCommentModel> _lstComments;
  @override
  List<TicketCommentModel> get lstComments {
    if (_lstComments is EqualUnmodifiableListView) return _lstComments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstComments);
  }

  @override
  String toString() {
    return 'TicketDetailsState(lstComments: $lstComments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SupportDetailsState &&
            const DeepCollectionEquality()
                .equals(other._lstComments, _lstComments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_lstComments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SupportDetailsStateCopyWith<_$_SupportDetailsState> get copyWith =>
      __$$_SupportDetailsStateCopyWithImpl<_$_SupportDetailsState>(
          this, _$identity);
}

abstract class _SupportDetailsState implements TicketDetailsState {
  const factory _SupportDetailsState(
          {required final List<TicketCommentModel> lstComments}) =
      _$_SupportDetailsState;

  @override
  List<TicketCommentModel> get lstComments;
  @override
  @JsonKey(ignore: true)
  _$$_SupportDetailsStateCopyWith<_$_SupportDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}
