// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EmployeeDetailsState {
  List<CompanyDetailsModel> get lstService =>
      throw _privateConstructorUsedError;
  List<EmployeeDetailsModel> get lstEmployee =>
      throw _privateConstructorUsedError;
  bool get isGeneralVisible => throw _privateConstructorUsedError;
  bool get isPreferenceVisible => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmployeeDetailsStateCopyWith<EmployeeDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeDetailsStateCopyWith<$Res> {
  factory $EmployeeDetailsStateCopyWith(EmployeeDetailsState value,
          $Res Function(EmployeeDetailsState) then) =
      _$EmployeeDetailsStateCopyWithImpl<$Res, EmployeeDetailsState>;
  @useResult
  $Res call(
      {List<CompanyDetailsModel> lstService,
      List<EmployeeDetailsModel> lstEmployee,
      bool isGeneralVisible,
      bool isPreferenceVisible});
}

/// @nodoc
class _$EmployeeDetailsStateCopyWithImpl<$Res,
        $Val extends EmployeeDetailsState>
    implements $EmployeeDetailsStateCopyWith<$Res> {
  _$EmployeeDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstService = null,
    Object? lstEmployee = null,
    Object? isGeneralVisible = null,
    Object? isPreferenceVisible = null,
  }) {
    return _then(_value.copyWith(
      lstService: null == lstService
          ? _value.lstService
          : lstService // ignore: cast_nullable_to_non_nullable
              as List<CompanyDetailsModel>,
      lstEmployee: null == lstEmployee
          ? _value.lstEmployee
          : lstEmployee // ignore: cast_nullable_to_non_nullable
              as List<EmployeeDetailsModel>,
      isGeneralVisible: null == isGeneralVisible
          ? _value.isGeneralVisible
          : isGeneralVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreferenceVisible: null == isPreferenceVisible
          ? _value.isPreferenceVisible
          : isPreferenceVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EmployeeDetailsStateCopyWith<$Res>
    implements $EmployeeDetailsStateCopyWith<$Res> {
  factory _$$_EmployeeDetailsStateCopyWith(_$_EmployeeDetailsState value,
          $Res Function(_$_EmployeeDetailsState) then) =
      __$$_EmployeeDetailsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CompanyDetailsModel> lstService,
      List<EmployeeDetailsModel> lstEmployee,
      bool isGeneralVisible,
      bool isPreferenceVisible});
}

/// @nodoc
class __$$_EmployeeDetailsStateCopyWithImpl<$Res>
    extends _$EmployeeDetailsStateCopyWithImpl<$Res, _$_EmployeeDetailsState>
    implements _$$_EmployeeDetailsStateCopyWith<$Res> {
  __$$_EmployeeDetailsStateCopyWithImpl(_$_EmployeeDetailsState _value,
      $Res Function(_$_EmployeeDetailsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstService = null,
    Object? lstEmployee = null,
    Object? isGeneralVisible = null,
    Object? isPreferenceVisible = null,
  }) {
    return _then(_$_EmployeeDetailsState(
      lstService: null == lstService
          ? _value._lstService
          : lstService // ignore: cast_nullable_to_non_nullable
              as List<CompanyDetailsModel>,
      lstEmployee: null == lstEmployee
          ? _value._lstEmployee
          : lstEmployee // ignore: cast_nullable_to_non_nullable
              as List<EmployeeDetailsModel>,
      isGeneralVisible: null == isGeneralVisible
          ? _value.isGeneralVisible
          : isGeneralVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreferenceVisible: null == isPreferenceVisible
          ? _value.isPreferenceVisible
          : isPreferenceVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_EmployeeDetailsState implements _EmployeeDetailsState {
  const _$_EmployeeDetailsState(
      {required final List<CompanyDetailsModel> lstService,
      required final List<EmployeeDetailsModel> lstEmployee,
      required this.isGeneralVisible,
      required this.isPreferenceVisible})
      : _lstService = lstService,
        _lstEmployee = lstEmployee;

  final List<CompanyDetailsModel> _lstService;
  @override
  List<CompanyDetailsModel> get lstService {
    if (_lstService is EqualUnmodifiableListView) return _lstService;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstService);
  }

  final List<EmployeeDetailsModel> _lstEmployee;
  @override
  List<EmployeeDetailsModel> get lstEmployee {
    if (_lstEmployee is EqualUnmodifiableListView) return _lstEmployee;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstEmployee);
  }

  @override
  final bool isGeneralVisible;
  @override
  final bool isPreferenceVisible;

  @override
  String toString() {
    return 'EmployeeDetailsState(lstService: $lstService, lstEmployee: $lstEmployee, isGeneralVisible: $isGeneralVisible, isPreferenceVisible: $isPreferenceVisible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EmployeeDetailsState &&
            const DeepCollectionEquality()
                .equals(other._lstService, _lstService) &&
            const DeepCollectionEquality()
                .equals(other._lstEmployee, _lstEmployee) &&
            (identical(other.isGeneralVisible, isGeneralVisible) ||
                other.isGeneralVisible == isGeneralVisible) &&
            (identical(other.isPreferenceVisible, isPreferenceVisible) ||
                other.isPreferenceVisible == isPreferenceVisible));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_lstService),
      const DeepCollectionEquality().hash(_lstEmployee),
      isGeneralVisible,
      isPreferenceVisible);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EmployeeDetailsStateCopyWith<_$_EmployeeDetailsState> get copyWith =>
      __$$_EmployeeDetailsStateCopyWithImpl<_$_EmployeeDetailsState>(
          this, _$identity);
}

abstract class _EmployeeDetailsState implements EmployeeDetailsState {
  const factory _EmployeeDetailsState(
      {required final List<CompanyDetailsModel> lstService,
      required final List<EmployeeDetailsModel> lstEmployee,
      required final bool isGeneralVisible,
      required final bool isPreferenceVisible}) = _$_EmployeeDetailsState;

  @override
  List<CompanyDetailsModel> get lstService;
  @override
  List<EmployeeDetailsModel> get lstEmployee;
  @override
  bool get isGeneralVisible;
  @override
  bool get isPreferenceVisible;
  @override
  @JsonKey(ignore: true)
  _$$_EmployeeDetailsStateCopyWith<_$_EmployeeDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}
