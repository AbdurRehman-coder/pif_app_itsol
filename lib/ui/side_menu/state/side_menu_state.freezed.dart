// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'side_menu_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SideMenuState {
  ThemeMode? get selectedTheme => throw _privateConstructorUsedError;
  List<ThemeModel>? get lstTheme => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SideMenuStateCopyWith<SideMenuState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SideMenuStateCopyWith<$Res> {
  factory $SideMenuStateCopyWith(
          SideMenuState value, $Res Function(SideMenuState) then) =
      _$SideMenuStateCopyWithImpl<$Res, SideMenuState>;
  @useResult
  $Res call({ThemeMode? selectedTheme, List<ThemeModel>? lstTheme});
}

/// @nodoc
class _$SideMenuStateCopyWithImpl<$Res, $Val extends SideMenuState>
    implements $SideMenuStateCopyWith<$Res> {
  _$SideMenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTheme = freezed,
    Object? lstTheme = freezed,
  }) {
    return _then(_value.copyWith(
      selectedTheme: freezed == selectedTheme
          ? _value.selectedTheme
          : selectedTheme // ignore: cast_nullable_to_non_nullable
              as ThemeMode?,
      lstTheme: freezed == lstTheme
          ? _value.lstTheme
          : lstTheme // ignore: cast_nullable_to_non_nullable
              as List<ThemeModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SideMenuStateCopyWith<$Res>
    implements $SideMenuStateCopyWith<$Res> {
  factory _$$_SideMenuStateCopyWith(
          _$_SideMenuState value, $Res Function(_$_SideMenuState) then) =
      __$$_SideMenuStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ThemeMode? selectedTheme, List<ThemeModel>? lstTheme});
}

/// @nodoc
class __$$_SideMenuStateCopyWithImpl<$Res>
    extends _$SideMenuStateCopyWithImpl<$Res, _$_SideMenuState>
    implements _$$_SideMenuStateCopyWith<$Res> {
  __$$_SideMenuStateCopyWithImpl(
      _$_SideMenuState _value, $Res Function(_$_SideMenuState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedTheme = freezed,
    Object? lstTheme = freezed,
  }) {
    return _then(_$_SideMenuState(
      selectedTheme: freezed == selectedTheme
          ? _value.selectedTheme
          : selectedTheme // ignore: cast_nullable_to_non_nullable
              as ThemeMode?,
      lstTheme: freezed == lstTheme
          ? _value._lstTheme
          : lstTheme // ignore: cast_nullable_to_non_nullable
              as List<ThemeModel>?,
    ));
  }
}

/// @nodoc

class _$_SideMenuState implements _SideMenuState {
  const _$_SideMenuState(
      {required this.selectedTheme, final List<ThemeModel>? lstTheme})
      : _lstTheme = lstTheme;

  @override
  final ThemeMode? selectedTheme;
  final List<ThemeModel>? _lstTheme;
  @override
  List<ThemeModel>? get lstTheme {
    final value = _lstTheme;
    if (value == null) return null;
    if (_lstTheme is EqualUnmodifiableListView) return _lstTheme;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SideMenuState(selectedTheme: $selectedTheme, lstTheme: $lstTheme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SideMenuState &&
            (identical(other.selectedTheme, selectedTheme) ||
                other.selectedTheme == selectedTheme) &&
            const DeepCollectionEquality().equals(other._lstTheme, _lstTheme));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedTheme,
      const DeepCollectionEquality().hash(_lstTheme));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SideMenuStateCopyWith<_$_SideMenuState> get copyWith =>
      __$$_SideMenuStateCopyWithImpl<_$_SideMenuState>(this, _$identity);
}

abstract class _SideMenuState implements SideMenuState {
  const factory _SideMenuState(
      {required final ThemeMode? selectedTheme,
      final List<ThemeModel>? lstTheme}) = _$_SideMenuState;

  @override
  ThemeMode? get selectedTheme;
  @override
  List<ThemeModel>? get lstTheme;
  @override
  @JsonKey(ignore: true)
  _$$_SideMenuStateCopyWith<_$_SideMenuState> get copyWith =>
      throw _privateConstructorUsedError;
}
