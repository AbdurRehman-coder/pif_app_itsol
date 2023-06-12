// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drinks_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DrinksState {
  List<CategoryModel> get lstCategory => throw _privateConstructorUsedError;
  AsyncValue<List<DrinkModel>> get lstDrinks =>
      throw _privateConstructorUsedError;
  List<DrinkModel> get lstCarts => throw _privateConstructorUsedError;
  AsyncValue<StructureContentModel> get structureContent =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DrinksStateCopyWith<DrinksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrinksStateCopyWith<$Res> {
  factory $DrinksStateCopyWith(
          DrinksState value, $Res Function(DrinksState) then) =
      _$DrinksStateCopyWithImpl<$Res, DrinksState>;
  @useResult
  $Res call(
      {List<CategoryModel> lstCategory,
      AsyncValue<List<DrinkModel>> lstDrinks,
      List<DrinkModel> lstCarts,
      AsyncValue<StructureContentModel> structureContent});
}

/// @nodoc
class _$DrinksStateCopyWithImpl<$Res, $Val extends DrinksState>
    implements $DrinksStateCopyWith<$Res> {
  _$DrinksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstCategory = null,
    Object? lstDrinks = null,
    Object? lstCarts = null,
    Object? structureContent = null,
  }) {
    return _then(_value.copyWith(
      lstCategory: null == lstCategory
          ? _value.lstCategory
          : lstCategory // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      lstDrinks: null == lstDrinks
          ? _value.lstDrinks
          : lstDrinks // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<DrinkModel>>,
      lstCarts: null == lstCarts
          ? _value.lstCarts
          : lstCarts // ignore: cast_nullable_to_non_nullable
              as List<DrinkModel>,
      structureContent: null == structureContent
          ? _value.structureContent
          : structureContent // ignore: cast_nullable_to_non_nullable
              as AsyncValue<StructureContentModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DrinksStateCopyWith<$Res>
    implements $DrinksStateCopyWith<$Res> {
  factory _$$_DrinksStateCopyWith(
          _$_DrinksState value, $Res Function(_$_DrinksState) then) =
      __$$_DrinksStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CategoryModel> lstCategory,
      AsyncValue<List<DrinkModel>> lstDrinks,
      List<DrinkModel> lstCarts,
      AsyncValue<StructureContentModel> structureContent});
}

/// @nodoc
class __$$_DrinksStateCopyWithImpl<$Res>
    extends _$DrinksStateCopyWithImpl<$Res, _$_DrinksState>
    implements _$$_DrinksStateCopyWith<$Res> {
  __$$_DrinksStateCopyWithImpl(
      _$_DrinksState _value, $Res Function(_$_DrinksState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstCategory = null,
    Object? lstDrinks = null,
    Object? lstCarts = null,
    Object? structureContent = null,
  }) {
    return _then(_$_DrinksState(
      lstCategory: null == lstCategory
          ? _value._lstCategory
          : lstCategory // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      lstDrinks: null == lstDrinks
          ? _value.lstDrinks
          : lstDrinks // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<DrinkModel>>,
      lstCarts: null == lstCarts
          ? _value._lstCarts
          : lstCarts // ignore: cast_nullable_to_non_nullable
              as List<DrinkModel>,
      structureContent: null == structureContent
          ? _value.structureContent
          : structureContent // ignore: cast_nullable_to_non_nullable
              as AsyncValue<StructureContentModel>,
    ));
  }
}

/// @nodoc

class _$_DrinksState implements _DrinksState {
  const _$_DrinksState(
      {required final List<CategoryModel> lstCategory,
      required this.lstDrinks,
      required final List<DrinkModel> lstCarts,
      required this.structureContent})
      : _lstCategory = lstCategory,
        _lstCarts = lstCarts;

  final List<CategoryModel> _lstCategory;
  @override
  List<CategoryModel> get lstCategory {
    if (_lstCategory is EqualUnmodifiableListView) return _lstCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstCategory);
  }

  @override
  final AsyncValue<List<DrinkModel>> lstDrinks;
  final List<DrinkModel> _lstCarts;
  @override
  List<DrinkModel> get lstCarts {
    if (_lstCarts is EqualUnmodifiableListView) return _lstCarts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstCarts);
  }

  @override
  final AsyncValue<StructureContentModel> structureContent;

  @override
  String toString() {
    return 'DrinksState(lstCategory: $lstCategory, lstDrinks: $lstDrinks, lstCarts: $lstCarts, structureContent: $structureContent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DrinksState &&
            const DeepCollectionEquality()
                .equals(other._lstCategory, _lstCategory) &&
            (identical(other.lstDrinks, lstDrinks) ||
                other.lstDrinks == lstDrinks) &&
            const DeepCollectionEquality().equals(other._lstCarts, _lstCarts) &&
            (identical(other.structureContent, structureContent) ||
                other.structureContent == structureContent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_lstCategory),
      lstDrinks,
      const DeepCollectionEquality().hash(_lstCarts),
      structureContent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DrinksStateCopyWith<_$_DrinksState> get copyWith =>
      __$$_DrinksStateCopyWithImpl<_$_DrinksState>(this, _$identity);
}

abstract class _DrinksState implements DrinksState {
  const factory _DrinksState(
          {required final List<CategoryModel> lstCategory,
          required final AsyncValue<List<DrinkModel>> lstDrinks,
          required final List<DrinkModel> lstCarts,
          required final AsyncValue<StructureContentModel> structureContent}) =
      _$_DrinksState;

  @override
  List<CategoryModel> get lstCategory;
  @override
  AsyncValue<List<DrinkModel>> get lstDrinks;
  @override
  List<DrinkModel> get lstCarts;
  @override
  AsyncValue<StructureContentModel> get structureContent;
  @override
  @JsonKey(ignore: true)
  _$$_DrinksStateCopyWith<_$_DrinksState> get copyWith =>
      throw _privateConstructorUsedError;
}
