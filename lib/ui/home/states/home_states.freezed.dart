// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeStates {
  List<CategoryModel> get lstCategory => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStatesCopyWith<HomeStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStatesCopyWith<$Res> {
  factory $HomeStatesCopyWith(
          HomeStates value, $Res Function(HomeStates) then) =
      _$HomeStatesCopyWithImpl<$Res, HomeStates>;
  @useResult
  $Res call({List<CategoryModel> lstCategory});
}

/// @nodoc
class _$HomeStatesCopyWithImpl<$Res, $Val extends HomeStates>
    implements $HomeStatesCopyWith<$Res> {
  _$HomeStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstCategory = null,
  }) {
    return _then(_value.copyWith(
      lstCategory: null == lstCategory
          ? _value.lstCategory
          : lstCategory // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeStatesCopyWith<$Res>
    implements $HomeStatesCopyWith<$Res> {
  factory _$$_HomeStatesCopyWith(
          _$_HomeStates value, $Res Function(_$_HomeStates) then) =
      __$$_HomeStatesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CategoryModel> lstCategory});
}

/// @nodoc
class __$$_HomeStatesCopyWithImpl<$Res>
    extends _$HomeStatesCopyWithImpl<$Res, _$_HomeStates>
    implements _$$_HomeStatesCopyWith<$Res> {
  __$$_HomeStatesCopyWithImpl(
      _$_HomeStates _value, $Res Function(_$_HomeStates) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lstCategory = null,
  }) {
    return _then(_$_HomeStates(
      lstCategory: null == lstCategory
          ? _value._lstCategory
          : lstCategory // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
    ));
  }
}

/// @nodoc

class _$_HomeStates implements _HomeStates {
  const _$_HomeStates({required final List<CategoryModel> lstCategory})
      : _lstCategory = lstCategory;

  final List<CategoryModel> _lstCategory;
  @override
  List<CategoryModel> get lstCategory {
    if (_lstCategory is EqualUnmodifiableListView) return _lstCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lstCategory);
  }

  @override
  String toString() {
    return 'HomeStates(lstCategory: $lstCategory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeStates &&
            const DeepCollectionEquality()
                .equals(other._lstCategory, _lstCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_lstCategory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeStatesCopyWith<_$_HomeStates> get copyWith =>
      __$$_HomeStatesCopyWithImpl<_$_HomeStates>(this, _$identity);
}

abstract class _HomeStates implements HomeStates {
  const factory _HomeStates({required final List<CategoryModel> lstCategory}) =
      _$_HomeStates;

  @override
  List<CategoryModel> get lstCategory;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStatesCopyWith<_$_HomeStates> get copyWith =>
      throw _privateConstructorUsedError;
}
