import 'package:flutter/material.dart';

import '../app_colors.dart';

part 'color_scheme.dart';
part 'text_theme.dart';
part 'input_decoration_theme.dart';
part 'text_selection_theme.dart';
part 'elevated_button_theme.dart';

final theme = ThemeData(
  useMaterial3: true,
  fontFamily: "Inter",
  colorScheme: _colorScheme,
  textTheme: _textTheme,
  inputDecorationTheme: _inputDecorationTheme,
  textSelectionTheme: _textSelectionTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  splashColor: AppColors.blue.withOpacity(0.25),
);
