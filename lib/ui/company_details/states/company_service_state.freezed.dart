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
mixin _$CompanyServiceState {
  List<CompanyServiceModel> get lstService => throw _privateConstructorUsedError;
  List<CompanyServiceUserModel> get lstUser => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompanyServiceStateCopyWith<CompanyServiceState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyServiceStateCopyWith<$Res> {
  factory $CompanyServiceStateCopyWith(CompanyServiceState value, $Res Function(CompanyServiceState) then) =
      _$CompanyServiceStateCopyWithImpl<$Res, CompanyServiceState>;
  @useResult
  $Res call({List<CompanyServiceModel> lstService, List<CompanyServiceUserModel> lstUser});
}

/// @nodoc
class _$CompanyServiceStateCopyWithImpl<$Res, $Val extends CompanyServiceState>
    implements $CompanyServiceStateCopyWith<$Res> {
  _$CompanyServiceStateCopyWithImpl(this._value, this._then);

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
              as List<CompanyServiceModel>,
      lstUser: null == lstUser
          ? _value.lstUser
          : lstUser // ignore: cast_nullable_to_non_nullable
              as List<CompanyServiceUserModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompanyServiceStateCopyWith<$Res> implements $CompanyServiceStateCopyWith<$Res> {
  factory _$$_CompanyServiceStateCopyWith(
          _$_CompanyServiceState value, $Res Function(_$_CompanyServiceState) then) =
      __$$_CompanyServiceStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CompanyServiceModel> lstService, List<CompanyServiceUserModel> lstUser});
}

/// @nodoc
class __$$_CompanyServiceStateCopyWithImpl<$Res>
    extends _$CompanyServiceStateCopyWithImpl<$Res, _$_CompanyServiceState>
    implements _$$_CompanyServiceStateCopyWith<$Res> {
  __$$_CompanyServiceStateCopyWithImpl(
      _$_CompanyServiceState _value, $Res Function(_$_CompanyServiceState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstService = null,
    Object? lstUser = null,
  }) {
    return _then(_$_CompanyServiceState(
      lstService: null == lstService
          ? _value._lstService
          : lstService // ignore: cast_nullable_to_non_nullable
              as List<CompanyServiceModel>,
      lstUser: null == lstUser
          ? _value._lstUser
          : lstUser // ignore: cast_nullable_to_non_nullable
              as List<CompanyServiceUserModel>,
    ));
  }
}

/// @nodoc

class _$_CompanyServiceState implements _CompanyServiceState {
  const _$_CompanyServiceState(
      {required final List<CompanyServiceModel> lstService,
      required final List<CompanyServiceUserModel> lstUser})
      : _lstService = lstService,
        _lstUser = lstUser;

  final List<CompanyServiceModel> _lstService;
  @override
  List<CompanyServiceModel> get lstService {
    if (_lstService is EqualUnmodifiableListView) return _lstService;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstService);
  }

  final List<CompanyServiceUserModel> _lstUser;
  @override
  List<CompanyServiceUserModel> get lstUser {
    if (_lstUser is EqualUnmodifiableListView) return _lstUser;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstUser);
  }

  @override
  String toString() {
    return 'CompanyServiceState(lstService: $lstService, lstUser: $lstUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompanyServiceState &&
            const DeepCollectionEquality().equals(other._lstService, _lstService) &&
            const DeepCollectionEquality().equals(other._lstUser, _lstUser));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_lstService),
      const DeepCollectionEquality().hash(_lstUser));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompanyServiceStateCopyWith<_$_CompanyServiceState> get copyWith =>
      __$$_CompanyServiceStateCopyWithImpl<_$_CompanyServiceState>(this, _$identity);
}

abstract class _CompanyServiceState implements CompanyServiceState {
  const factory _CompanyServiceState(
      {required final List<CompanyServiceModel> lstService,
      required final List<CompanyServiceUserModel> lstUser}) = _$_CompanyServiceState;

  @override
  List<CompanyServiceModel> get lstService;
  @override
  List<CompanyServiceUserModel> get lstUser;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyServiceStateCopyWith<_$_CompanyServiceState> get copyWith => throw _privateConstructorUsedError;
}
