part of 'theme.dart';

final _appBarTheme = AppBarTheme(
  shape: const Border(bottom: BorderSide(color: AppColors.greyLight)),
  iconTheme: const IconThemeData(
    color: AppColors.blue,
  ),
  titleTextStyle: _textTheme.bodyLarge?.copyWith(color: AppColors.black),
);
