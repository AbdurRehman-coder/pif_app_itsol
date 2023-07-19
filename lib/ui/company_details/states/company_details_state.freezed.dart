// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CompanyDetailsState {
  List<CompanyDetailsModel> get lstService =>
      throw _privateConstructorUsedError;
  List<CompanyDetailsUserModel> get lstUser =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompanyDetailsStateCopyWith<CompanyDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyDetailsStateCopyWith<$Res> {
  factory $CompanyDetailsStateCopyWith(
          CompanyDetailsState value, $Res Function(CompanyDetailsState) then) =
      _$CompanyDetailsStateCopyWithImpl<$Res, CompanyDetailsState>;
  @useResult
  $Res call(
      {List<CompanyDetailsModel> lstService,
      List<CompanyDetailsUserModel> lstUser});
}

/// @nodoc
class _$CompanyDetailsStateCopyWithImpl<$Res, $Val extends CompanyDetailsState>
    implements $CompanyDetailsStateCopyWith<$Res> {
  _$CompanyDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstService = null,
    Object? lstUser = null,
  }) {
    return _then(_value.copyWith(
      lstService: null == lstService
          ? _value.lstService
          : lstService // ignore: cast_nullable_to_non_nullable
              as List<CompanyDetailsModel>,
      lstUser: null == lstUser
          ? _value.lstUser
          : lstUser // ignore: cast_nullable_to_non_nullable
              as List<CompanyDetailsUserModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompanyDetailsStateCopyWith<$Res>
    implements $CompanyDetailsStateCopyWith<$Res> {
  factory _$$_CompanyDetailsStateCopyWith(_$_CompanyDetailsState value,
          $Res Function(_$_CompanyDetailsState) then) =
      __$$_CompanyDetailsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CompanyDetailsModel> lstService,
      List<CompanyDetailsUserModel> lstUser});
}

/// @nodoc
class __$$_CompanyDetailsStateCopyWithImpl<$Res>
    extends _$CompanyDetailsStateCopyWithImpl<$Res, _$_CompanyDetailsState>
    implements _$$_CompanyDetailsStateCopyWith<$Res> {
  __$$_CompanyDetailsStateCopyWithImpl(_$_CompanyDetailsState _value,
      $Res Function(_$_CompanyDetailsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstService = null,
    Object? lstUser = null,
  }) {
    return _then(_$_CompanyDetailsState(
      lstService: null == lstService
          ? _value._lstService
          : lstService // ignore: cast_nullable_to_non_nullable
              as List<CompanyDetailsModel>,
      lstUser: null == lstUser
          ? _value._lstUser
          : lstUser // ignore: cast_nullable_to_non_nullable
              as List<CompanyDetailsUserModel>,
    ));
  }
}

/// @nodoc

class _$_CompanyDetailsState implements _CompanyDetailsState {
  const _$_CompanyDetailsState(
      {required final List<CompanyDetailsModel> lstService,
      required final List<CompanyDetailsUserModel> lstUser})
      : _lstService = lstService,
        _lstUser = lstUser;

  final List<CompanyDetailsModel> _lstService;
  @override
  List<CompanyDetailsModel> get lstService {
    if (_lstService is EqualUnmodifiableListView) return _lstService;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstService);
  }

  final List<CompanyDetailsUserModel> _lstUser;
  @override
  List<CompanyDetailsUserModel> get lstUser {
    if (_lstUser is EqualUnmodifiableListView) return _lstUser;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstUser);
  }

  @override
  String toString() {
    return 'CompanyDetailsState(lstService: $lstService, lstUser: $lstUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompanyDetailsState &&
            const DeepCollectionEquality()
                .equals(other._lstService, _lstService) &&
            const DeepCollectionEquality().equals(other._lstUser, _lstUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_lstService),
      const DeepCollectionEquality().hash(_lstUser));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompanyDetailsStateCopyWith<_$_CompanyDetailsState> get copyWith =>
      __$$_CompanyDetailsStateCopyWithImpl<_$_CompanyDetailsState>(
          this, _$identity);
}

abstract class _CompanyDetailsState implements CompanyDetailsState {
  const factory _CompanyDetailsState(
          {required final List<CompanyDetailsModel> lstService,
          required final List<CompanyDetailsUserModel> lstUser}) =
      _$_CompanyDetailsState;

  @override
  List<CompanyDetailsModel> get lstService;
  @override
  List<CompanyDetailsUserModel> get lstUser;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyDetailsStateCopyWith<_$_CompanyDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}
