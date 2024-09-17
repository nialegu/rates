part of 'theme.dart';

final _inputDecorationTheme = InputDecorationTheme(
  labelStyle: _textTheme.bodyLarge,
  floatingLabelBehavior: FloatingLabelBehavior.always,
  floatingLabelAlignment: FloatingLabelAlignment.start,
  border: OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.grey),
    borderRadius: _borderRadius,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.grey),
    borderRadius: _borderRadius,
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.black, width: 1.5),
    borderRadius: _borderRadius,
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.red),
    borderRadius: _borderRadius,
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.red),
    borderRadius: _borderRadius,
  ),
  errorStyle: _textTheme.bodyMedium?.copyWith(color: AppColors.red),
);

final _borderRadius = BorderRadius.circular(8);
