// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fill_information_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FillInformationState {
  int get selectedScreen => throw _privateConstructorUsedError;
  AsyncValue<List<NationalityModel>> get nationalList =>
      throw _privateConstructorUsedError;
  File? get scanFace => throw _privateConstructorUsedError;
  NationalityModel? get nationalitySelect => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FillInformationStateCopyWith<FillInformationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FillInformationStateCopyWith<$Res> {
  factory $FillInformationStateCopyWith(FillInformationState value,
          $Res Function(FillInformationState) then) =
      _$FillInformationStateCopyWithImpl<$Res, FillInformationState>;
  @useResult
  $Res call(
      {int selectedScreen,
      AsyncValue<List<NationalityModel>> nationalList,
      File? scanFace,
      NationalityModel? nationalitySelect});
}

/// @nodoc
class _$FillInformationStateCopyWithImpl<$Res,
        $Val extends FillInformationState>
    implements $FillInformationStateCopyWith<$Res> {
  _$FillInformationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedScreen = null,
    Object? nationalList = null,
    Object? scanFace = freezed,
    Object? nationalitySelect = freezed,
  }) {
    return _then(_value.copyWith(
      selectedScreen: null == selectedScreen
          ? _value.selectedScreen
          : selectedScreen // ignore: cast_nullable_to_non_nullable
              as int,
      nationalList: null == nationalList
          ? _value.nationalList
          : nationalList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<NationalityModel>>,
      scanFace: freezed == scanFace
          ? _value.scanFace
          : scanFace // ignore: cast_nullable_to_non_nullable
              as File?,
      nationalitySelect: freezed == nationalitySelect
          ? _value.nationalitySelect
          : nationalitySelect // ignore: cast_nullable_to_non_nullable
              as NationalityModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FillInformationStateCopyWith<$Res>
    implements $FillInformationStateCopyWith<$Res> {
  factory _$$_FillInformationStateCopyWith(_$_FillInformationState value,
          $Res Function(_$_FillInformationState) then) =
      __$$_FillInformationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int selectedScreen,
      AsyncValue<List<NationalityModel>> nationalList,
      File? scanFace,
      NationalityModel? nationalitySelect});
}

/// @nodoc
class __$$_FillInformationStateCopyWithImpl<$Res>
    extends _$FillInformationStateCopyWithImpl<$Res, _$_FillInformationState>
    implements _$$_FillInformationStateCopyWith<$Res> {
  __$$_FillInformationStateCopyWithImpl(_$_FillInformationState _value,
      $Res Function(_$_FillInformationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedScreen = null,
    Object? nationalList = null,
    Object? scanFace = freezed,
    Object? nationalitySelect = freezed,
  }) {
    return _then(_$_FillInformationState(
      selectedScreen: null == selectedScreen
          ? _value.selectedScreen
          : selectedScreen // ignore: cast_nullable_to_non_nullable
              as int,
      nationalList: null == nationalList
          ? _value.nationalList
          : nationalList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<NationalityModel>>,
      scanFace: freezed == scanFace
          ? _value.scanFace
          : scanFace // ignore: cast_nullable_to_non_nullable
              as File?,
      nationalitySelect: freezed == nationalitySelect
          ? _value.nationalitySelect
          : nationalitySelect // ignore: cast_nullable_to_non_nullable
              as NationalityModel?,
    ));
  }
}

/// @nodoc

class _$_FillInformationState implements _FillInformationState {
  const _$_FillInformationState(
      {required this.selectedScreen,
      required this.nationalList,
      required this.scanFace,
      required this.nationalitySelect});

  @override
  final int selectedScreen;
  @override
  final AsyncValue<List<NationalityModel>> nationalList;
  @override
  final File? scanFace;
  @override
  final NationalityModel? nationalitySelect;

  @override
  String toString() {
    return 'FillInformationState(selectedScreen: $selectedScreen, nationalList: $nationalList, scanFace: $scanFace, nationalitySelect: $nationalitySelect)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FillInformationState &&
            (identical(other.selectedScreen, selectedScreen) ||
                other.selectedScreen == selectedScreen) &&
            (identical(other.nationalList, nationalList) ||
                other.nationalList == nationalList) &&
            (identical(other.scanFace, scanFace) ||
                other.scanFace == scanFace) &&
            (identical(other.nationalitySelect, nationalitySelect) ||
                other.nationalitySelect == nationalitySelect));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedScreen, nationalList, scanFace, nationalitySelect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FillInformationStateCopyWith<_$_FillInformationState> get copyWith =>
      __$$_FillInformationStateCopyWithImpl<_$_FillInformationState>(
          this, _$identity);
}

abstract class _FillInformationState implements FillInformationState {
  const factory _FillInformationState(
          {required final int selectedScreen,
          required final AsyncValue<List<NationalityModel>> nationalList,
          required final File? scanFace,
          required final NationalityModel? nationalitySelect}) =
      _$_FillInformationState;

  @override
  int get selectedScreen;
  @override
  AsyncValue<List<NationalityModel>> get nationalList;
  @override
  File? get scanFace;
  @override
  NationalityModel? get nationalitySelect;
  @override
  @JsonKey(ignore: true)
  _$$_FillInformationStateCopyWith<_$_FillInformationState> get copyWith =>
      throw _privateConstructorUsedError;
}