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
  bool get loadImage => throw _privateConstructorUsedError;
  bool get isTeamSelected => throw _privateConstructorUsedError;
  AsyncValue<List<TeamsModel>> get teamList =>
      throw _privateConstructorUsedError;
  SubCategoryModel? get subcategorySelected =>
      throw _privateConstructorUsedError;
  AsyncValue<List<SubCategoryModel>> get subCategoryList =>
      throw _privateConstructorUsedError;

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
  $Res call(
      {XFile? image,
      bool loadImage,
      bool isTeamSelected,
      AsyncValue<List<TeamsModel>> teamList,
      SubCategoryModel? subcategorySelected,
      AsyncValue<List<SubCategoryModel>> subCategoryList});
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
    Object? loadImage = null,
    Object? isTeamSelected = null,
    Object? teamList = null,
    Object? subcategorySelected = freezed,
    Object? subCategoryList = null,
  }) {
    return _then(_value.copyWith(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as XFile?,
      loadImage: null == loadImage
          ? _value.loadImage
          : loadImage // ignore: cast_nullable_to_non_nullable
              as bool,
      isTeamSelected: null == isTeamSelected
          ? _value.isTeamSelected
          : isTeamSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      teamList: null == teamList
          ? _value.teamList
          : teamList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TeamsModel>>,
      subcategorySelected: freezed == subcategorySelected
          ? _value.subcategorySelected
          : subcategorySelected // ignore: cast_nullable_to_non_nullable
              as SubCategoryModel?,
      subCategoryList: null == subCategoryList
          ? _value.subCategoryList
          : subCategoryList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SubCategoryModel>>,
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
  $Res call(
      {XFile? image,
      bool loadImage,
      bool isTeamSelected,
      AsyncValue<List<TeamsModel>> teamList,
      SubCategoryModel? subcategorySelected,
      AsyncValue<List<SubCategoryModel>> subCategoryList});
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
    Object? loadImage = null,
    Object? isTeamSelected = null,
    Object? teamList = null,
    Object? subcategorySelected = freezed,
    Object? subCategoryList = null,
  }) {
    return _then(_$_AddOrEditTicketState(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as XFile?,
      loadImage: null == loadImage
          ? _value.loadImage
          : loadImage // ignore: cast_nullable_to_non_nullable
              as bool,
      isTeamSelected: null == isTeamSelected
          ? _value.isTeamSelected
          : isTeamSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      teamList: null == teamList
          ? _value.teamList
          : teamList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TeamsModel>>,
      subcategorySelected: freezed == subcategorySelected
          ? _value.subcategorySelected
          : subcategorySelected // ignore: cast_nullable_to_non_nullable
              as SubCategoryModel?,
      subCategoryList: null == subCategoryList
          ? _value.subCategoryList
          : subCategoryList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SubCategoryModel>>,
    ));
  }
}

/// @nodoc

class _$_AddOrEditTicketState implements _AddOrEditTicketState {
  const _$_AddOrEditTicketState(
      {required this.image,
      required this.loadImage,
      required this.isTeamSelected,
      required this.teamList,
      required this.subcategorySelected,
      required this.subCategoryList});

  @override
  final XFile? image;
  @override
  final bool loadImage;
  @override
  final bool isTeamSelected;
  @override
  final AsyncValue<List<TeamsModel>> teamList;
  @override
  final SubCategoryModel? subcategorySelected;
  @override
  final AsyncValue<List<SubCategoryModel>> subCategoryList;

  @override
  String toString() {
    return 'AddOrEditTicketState(image: $image, loadImage: $loadImage, isTeamSelected: $isTeamSelected, teamList: $teamList, subcategorySelected: $subcategorySelected, subCategoryList: $subCategoryList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddOrEditTicketState &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.loadImage, loadImage) ||
                other.loadImage == loadImage) &&
            (identical(other.isTeamSelected, isTeamSelected) ||
                other.isTeamSelected == isTeamSelected) &&
            (identical(other.teamList, teamList) ||
                other.teamList == teamList) &&
            (identical(other.subcategorySelected, subcategorySelected) ||
                other.subcategorySelected == subcategorySelected) &&
            (identical(other.subCategoryList, subCategoryList) ||
                other.subCategoryList == subCategoryList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image, loadImage, isTeamSelected,
      teamList, subcategorySelected, subCategoryList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddOrEditTicketStateCopyWith<_$_AddOrEditTicketState> get copyWith =>
      __$$_AddOrEditTicketStateCopyWithImpl<_$_AddOrEditTicketState>(
          this, _$identity);
}

abstract class _AddOrEditTicketState implements AddOrEditTicketState {
  const factory _AddOrEditTicketState(
          {required final XFile? image,
          required final bool loadImage,
          required final bool isTeamSelected,
          required final AsyncValue<List<TeamsModel>> teamList,
          required final SubCategoryModel? subcategorySelected,
          required final AsyncValue<List<SubCategoryModel>> subCategoryList}) =
      _$_AddOrEditTicketState;

  @override
  XFile? get image;
  @override
  bool get loadImage;
  @override
  bool get isTeamSelected;
  @override
  AsyncValue<List<TeamsModel>> get teamList;
  @override
  SubCategoryModel? get subcategorySelected;
  @override
  AsyncValue<List<SubCategoryModel>> get subCategoryList;
  @override
  @JsonKey(ignore: true)
  _$$_AddOrEditTicketStateCopyWith<_$_AddOrEditTicketState> get copyWith =>
      throw _privateConstructorUsedError;
}
