part of 'theme.dart';

final _textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    textStyle: WidgetStatePropertyAll(
      _textTheme.bodyMedium,
    ),
    foregroundColor: const WidgetStatePropertyAll(AppColors.blue)
  ),
);
