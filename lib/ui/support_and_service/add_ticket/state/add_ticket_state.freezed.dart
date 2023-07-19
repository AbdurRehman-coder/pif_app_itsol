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
  TicketCategoryModel? get selectedCategory =>
      throw _privateConstructorUsedError;
  TicketCategoryModel? get selectedSubCategory =>
      throw _privateConstructorUsedError;
  AsyncValue<List<TicketCategoryModel>> get lstCategory =>
      throw _privateConstructorUsedError;
  List<TicketCategoryModel> get lstSubCategory =>
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
      TicketCategoryModel? selectedCategory,
      TicketCategoryModel? selectedSubCategory,
      AsyncValue<List<TicketCategoryModel>> lstCategory,
      List<TicketCategoryModel> lstSubCategory});
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
    Object? selectedCategory = freezed,
    Object? selectedSubCategory = freezed,
    Object? lstCategory = null,
    Object? lstSubCategory = null,
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
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as TicketCategoryModel?,
      selectedSubCategory: freezed == selectedSubCategory
          ? _value.selectedSubCategory
          : selectedSubCategory // ignore: cast_nullable_to_non_nullable
              as TicketCategoryModel?,
      lstCategory: null == lstCategory
          ? _value.lstCategory
          : lstCategory // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TicketCategoryModel>>,
      lstSubCategory: null == lstSubCategory
          ? _value.lstSubCategory
          : lstSubCategory // ignore: cast_nullable_to_non_nullable
              as List<TicketCategoryModel>,
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
      TicketCategoryModel? selectedCategory,
      TicketCategoryModel? selectedSubCategory,
      AsyncValue<List<TicketCategoryModel>> lstCategory,
      List<TicketCategoryModel> lstSubCategory});
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
    Object? selectedCategory = freezed,
    Object? selectedSubCategory = freezed,
    Object? lstCategory = null,
    Object? lstSubCategory = null,
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
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as TicketCategoryModel?,
      selectedSubCategory: freezed == selectedSubCategory
          ? _value.selectedSubCategory
          : selectedSubCategory // ignore: cast_nullable_to_non_nullable
              as TicketCategoryModel?,
      lstCategory: null == lstCategory
          ? _value.lstCategory
          : lstCategory // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TicketCategoryModel>>,
      lstSubCategory: null == lstSubCategory
          ? _value._lstSubCategory
          : lstSubCategory // ignore: cast_nullable_to_non_nullable
              as List<TicketCategoryModel>,
    ));
  }
}

/// @nodoc

class _$_AddOrEditTicketState implements _AddOrEditTicketState {
  const _$_AddOrEditTicketState(
      {required this.image,
      required this.loadImage,
      required this.selectedCategory,
      required this.selectedSubCategory,
      required this.lstCategory,
      required final List<TicketCategoryModel> lstSubCategory})
      : _lstSubCategory = lstSubCategory;

  @override
  final XFile? image;
  @override
  final bool loadImage;
  @override
  final TicketCategoryModel? selectedCategory;
  @override
  final TicketCategoryModel? selectedSubCategory;
  @override
  final AsyncValue<List<TicketCategoryModel>> lstCategory;
  final List<TicketCategoryModel> _lstSubCategory;
  @override
  List<TicketCategoryModel> get lstSubCategory {
    if (_lstSubCategory is EqualUnmodifiableListView) return _lstSubCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstSubCategory);
  }

  @override
  String toString() {
    return 'AddOrEditTicketState(image: $image, loadImage: $loadImage, selectedCategory: $selectedCategory, selectedSubCategory: $selectedSubCategory, lstCategory: $lstCategory, lstSubCategory: $lstSubCategory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddOrEditTicketState &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.loadImage, loadImage) ||
                other.loadImage == loadImage) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.selectedSubCategory, selectedSubCategory) ||
                other.selectedSubCategory == selectedSubCategory) &&
            (identical(other.lstCategory, lstCategory) ||
                other.lstCategory == lstCategory) &&
            const DeepCollectionEquality()
                .equals(other._lstSubCategory, _lstSubCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      image,
      loadImage,
      selectedCategory,
      selectedSubCategory,
      lstCategory,
      const DeepCollectionEquality().hash(_lstSubCategory));

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
          required final TicketCategoryModel? selectedCategory,
          required final TicketCategoryModel? selectedSubCategory,
          required final AsyncValue<List<TicketCategoryModel>> lstCategory,
          required final List<TicketCategoryModel> lstSubCategory}) =
      _$_AddOrEditTicketState;

  @override
  XFile? get image;
  @override
  bool get loadImage;
  @override
  TicketCategoryModel? get selectedCategory;
  @override
  TicketCategoryModel? get selectedSubCategory;
  @override
  AsyncValue<List<TicketCategoryModel>> get lstCategory;
  @override
  List<TicketCategoryModel> get lstSubCategory;
  @override
  @JsonKey(ignore: true)
  _$$_AddOrEditTicketStateCopyWith<_$_AddOrEditTicketState> get copyWith =>
      throw _privateConstructorUsedError;
}
