// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banner_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BannerStates {
  List<BannerModel> get listBannerModel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BannerStatesCopyWith<BannerStates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerStatesCopyWith<$Res> {
  factory $BannerStatesCopyWith(
          BannerStates value, $Res Function(BannerStates) then) =
      _$BannerStatesCopyWithImpl<$Res, BannerStates>;
  @useResult
  $Res call({List<BannerModel> listBannerModel});
}

/// @nodoc
class _$BannerStatesCopyWithImpl<$Res, $Val extends BannerStates>
    implements $BannerStatesCopyWith<$Res> {
  _$BannerStatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listBannerModel = null,
  }) {
    return _then(_value.copyWith(
      listBannerModel: null == listBannerModel
          ? _value.listBannerModel
          : listBannerModel // ignore: cast_nullable_to_non_nullable
              as List<BannerModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BannerStatesCopyWith<$Res>
    implements $BannerStatesCopyWith<$Res> {
  factory _$$_BannerStatesCopyWith(
          _$_BannerStates value, $Res Function(_$_BannerStates) then) =
      __$$_BannerStatesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BannerModel> listBannerModel});
}

/// @nodoc
class __$$_BannerStatesCopyWithImpl<$Res>
    extends _$BannerStatesCopyWithImpl<$Res, _$_BannerStates>
    implements _$$_BannerStatesCopyWith<$Res> {
  __$$_BannerStatesCopyWithImpl(
      _$_BannerStates _value, $Res Function(_$_BannerStates) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listBannerModel = null,
  }) {
    return _then(_$_BannerStates(
      listBannerModel: null == listBannerModel
          ? _value._listBannerModel
          : listBannerModel // ignore: cast_nullable_to_non_nullable
              as List<BannerModel>,
    ));
  }
}

/// @nodoc

class _$_BannerStates implements _BannerStates {
  const _$_BannerStates({required final List<BannerModel> listBannerModel})
      : _listBannerModel = listBannerModel;

  final List<BannerModel> _listBannerModel;
  @override
  List<BannerModel> get listBannerModel {
    if (_listBannerModel is EqualUnmodifiableListView) return _listBannerModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listBannerModel);
  }

  @override
  String toString() {
    return 'BannerStates(listBannerModel: $listBannerModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BannerStates &&
            const DeepCollectionEquality()
                .equals(other._listBannerModel, _listBannerModel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_listBannerModel));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BannerStatesCopyWith<_$_BannerStates> get copyWith =>
      __$$_BannerStatesCopyWithImpl<_$_BannerStates>(this, _$identity);
}

abstract class _BannerStates implements BannerStates {
  const factory _BannerStates(
      {required final List<BannerModel> listBannerModel}) = _$_BannerStates;

  @override
  List<BannerModel> get listBannerModel;
  @override
  @JsonKey(ignore: true)
  _$$_BannerStatesCopyWith<_$_BannerStates> get copyWith =>
      throw _privateConstructorUsedError;
}
