part of 'theme.dart';

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll(AppColors.blue),
    overlayColor: WidgetStatePropertyAll(AppColors.white.withOpacity(0.25)),
    foregroundColor: const WidgetStatePropertyAll(AppColors.white),
    elevation: const WidgetStatePropertyAll(0),
    shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
    minimumSize: const WidgetStatePropertyAll(Size(370, 40)),
    textStyle: WidgetStatePropertyAll(_textTheme.bodyMedium),
  ),
);
