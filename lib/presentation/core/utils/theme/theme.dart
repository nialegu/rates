import 'package:flutter/material.dart';

import '../app_colors.dart';

part 'color_scheme.dart';
part 'text_theme.dart';

final theme = ThemeData(
  useMaterial3: true,
  fontFamily: "Inter",
  colorScheme: _colorScheme,
  textTheme: _textTheme,
);
