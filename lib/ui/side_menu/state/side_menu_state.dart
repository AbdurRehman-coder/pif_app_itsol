import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/side_menu/model/theme_model.dart';

part 'side_menu_state.freezed.dart';

@freezed
class SideMenuState with _$SideMenuState {
  const factory SideMenuState({
    required ThemeMode? selectedTheme,
    List<ThemeModel>? lstTheme,
  }) = _SideMenuState;

  factory SideMenuState.initial() => const SideMenuState(
        selectedTheme: null,
      );
}
