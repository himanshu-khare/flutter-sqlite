import '../core/app_export.dart';

class CustomTextStyles {
  static get bodyLargeWhite => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.white,
      );
  static get titleLarge20 => theme.textTheme.titleLarge!.copyWith(
        fontSize: 20.fSize,
      );
}

