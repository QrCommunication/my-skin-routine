import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme({ColorScheme? dynamicScheme}) {
    final colorScheme = dynamicScheme ??
        ColorScheme.fromSeed(
          seedColor: AppColors.seedColor,
          brightness: Brightness.light,
          surface: AppColors.lavandeSurface,
          surfaceContainerLowest: AppColors.lavandeSurfaceContainerLowest,
          surfaceContainerLow: AppColors.lavandeSurfaceContainerLow,
          surfaceContainer: AppColors.lavandeSurfaceContainer,
          surfaceContainerHigh: AppColors.lavandeSurfaceContainerHigh,
          surfaceContainerHighest: AppColors.lavandeSurfaceContainerHighest,
          inverseSurface: AppColors.lavandeInverseSurface,
          inversePrimary: AppColors.lavandeInversePrimary,
          scrim: AppColors.lavandeScrim,
          shadow: AppColors.lavandeShadow,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme,
      scaffoldBackgroundColor: AppColors.lavandeBackground,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: colorScheme.surfaceTint,
        titleTextStyle: AppTypography.textTheme.headlineSmall!
            .copyWith(color: colorScheme.onSurface),
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedColor: colorScheme.primary,
        disabledColor: colorScheme.surfaceContainerHigh,
        labelStyle: AppTypography.textTheme.labelLarge!
            .copyWith(color: colorScheme.onSurface),
        secondaryLabelStyle: AppTypography.textTheme.labelLarge!
            .copyWith(color: colorScheme.onSurfaceVariant),
        brightness: Brightness.light,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 6,
        focusElevation: 8,
        hoverElevation: 8,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.onSecondaryContainer);
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.textTheme.labelMedium!
                .copyWith(color: colorScheme.onSecondaryContainer);
          }
          return AppTypography.textTheme.labelMedium!
              .copyWith(color: colorScheme.onSurfaceVariant);
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surface,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        elevation: 0,
        selectedIconTheme: IconThemeData(
          color: colorScheme.onSecondaryContainer,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        labelStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurfaceVariant),
        hintStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurfaceVariant),
        errorStyle: AppTypography.textTheme.bodySmall!
            .copyWith(color: colorScheme.error),
        helperStyle: AppTypography.textTheme.bodySmall!
            .copyWith(color: colorScheme.onSurfaceVariant),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.surfaceContainerHigh,
        disabledActiveTrackColor: colorScheme.surfaceContainerHigh,
        disabledInactiveTrackColor: colorScheme.surfaceContainerHigh,
        activeTickMarkColor: colorScheme.onPrimary,
        inactiveTickMarkColor: colorScheme.onSurfaceVariant,
        disabledActiveTickMarkColor: colorScheme.onSurface,
        disabledInactiveTickMarkColor: colorScheme.onSurface,
        thumbColor: colorScheme.primary,
        disabledThumbColor: colorScheme.surfaceContainerHigh,
        overlayColor: colorScheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle: AppTypography.textTheme.labelMedium!
            .copyWith(color: colorScheme.onPrimary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surfaceContainerHigh;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surface;
        }),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return BorderSide(color: colorScheme.primary);
          }
          return BorderSide(color: colorScheme.outline);
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.surfaceContainerHigh,
        circularTrackColor: colorScheme.surfaceContainerHigh,
        refreshBackgroundColor: colorScheme.surface,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onInverseSurface),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        titleTextStyle: AppTypography.textTheme.headlineSmall!
            .copyWith(color: colorScheme.onSurface),
        contentTextStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurfaceVariant),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        clipBehavior: Clip.antiAlias,
        dragHandleColor: colorScheme.outlineVariant,
        surfaceTintColor: colorScheme.surfaceTint,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: AppTypography.textTheme.labelMedium!
            .copyWith(color: colorScheme.primary),
        unselectedLabelStyle: AppTypography.textTheme.labelMedium!
            .copyWith(color: colorScheme.onSurfaceVariant),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTypography.textTheme.bodySmall!
            .copyWith(color: colorScheme.onInverseSurface),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        showDuration: const Duration(milliseconds: 3000),
        waitDuration: const Duration(milliseconds: 500),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
        textStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurface),
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        contentTextStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurface),
        elevation: 3,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        textColor: colorScheme.onSurface,
        iconColor: colorScheme.onSurfaceVariant,
        collapsedTextColor: colorScheme.onSurface,
        collapsedIconColor: colorScheme.onSurfaceVariant,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorScheme.primary, width: 3),
        ),
        labelStyle: AppTypography.textTheme.labelLarge,
        unselectedLabelStyle: AppTypography.textTheme.labelLarge,
        dividerColor: colorScheme.outlineVariant,
      ),
    );
  }

  static ThemeData darkTheme({ColorScheme? dynamicScheme}) {
    final colorScheme = dynamicScheme ??
        ColorScheme.fromSeed(
          seedColor: AppColors.seedColor,
          brightness: Brightness.dark,
          surface: AppColors.lavandeInverseSurface,
          surfaceContainerLowest: Color.alphaBlend(
            AppColors.seedColor.withOpacity(0.05),
            AppColors.lavandeInverseSurface,
          ),
          surfaceContainerLow: Color.alphaBlend(
            AppColors.seedColor.withOpacity(0.1),
            AppColors.lavandeInverseSurface,
          ),
          surfaceContainer: Color.alphaBlend(
            AppColors.seedColor.withOpacity(0.15),
            AppColors.lavandeInverseSurface,
          ),
          surfaceContainerHigh: Color.alphaBlend(
            AppColors.seedColor.withOpacity(0.20),
            AppColors.lavandeInverseSurface,
          ),
          surfaceContainerHighest: Color.alphaBlend(
            AppColors.seedColor.withOpacity(0.25),
            AppColors.lavandeInverseSurface,
          ),
          inverseSurface: AppColors.lavandeBackground,
          inversePrimary: AppColors.lavandePrimary,
          scrim: AppColors.lavandeScrim,
          shadow: AppColors.lavandeShadow,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: colorScheme.surfaceTint,
        titleTextStyle: AppTypography.textTheme.headlineSmall!
            .copyWith(color: colorScheme.onSurface),
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedColor: colorScheme.primary,
        disabledColor: colorScheme.surfaceContainerHigh,
        labelStyle: AppTypography.textTheme.labelLarge!
            .copyWith(color: colorScheme.onSurface),
        secondaryLabelStyle: AppTypography.textTheme.labelLarge!
            .copyWith(color: colorScheme.onSurfaceVariant),
        brightness: Brightness.dark,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 6,
        focusElevation: 8,
        hoverElevation: 8,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.onSecondaryContainer);
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.textTheme.labelMedium!
                .copyWith(color: colorScheme.onSecondaryContainer);
          }
          return AppTypography.textTheme.labelMedium!
              .copyWith(color: colorScheme.onSurfaceVariant);
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surface,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        elevation: 0,
        selectedIconTheme: IconThemeData(
          color: colorScheme.onSecondaryContainer,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        labelStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurfaceVariant),
        hintStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurfaceVariant),
        errorStyle: AppTypography.textTheme.bodySmall!
            .copyWith(color: colorScheme.error),
        helperStyle: AppTypography.textTheme.bodySmall!
            .copyWith(color: colorScheme.onSurfaceVariant),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.surfaceContainerHigh,
        disabledActiveTrackColor: colorScheme.surfaceContainerHigh,
        disabledInactiveTrackColor: colorScheme.surfaceContainerHigh,
        activeTickMarkColor: colorScheme.onPrimary,
        inactiveTickMarkColor: colorScheme.onSurfaceVariant,
        disabledActiveTickMarkColor: colorScheme.onSurface,
        disabledInactiveTickMarkColor: colorScheme.onSurface,
        thumbColor: colorScheme.primary,
        disabledThumbColor: colorScheme.surfaceContainerHigh,
        overlayColor: colorScheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle: AppTypography.textTheme.labelMedium!
            .copyWith(color: colorScheme.onPrimary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surfaceContainerHigh;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surface;
        }),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return BorderSide(color: colorScheme.primary);
          }
          return BorderSide(color: colorScheme.outline);
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.surfaceContainerHigh,
        circularTrackColor: colorScheme.surfaceContainerHigh,
        refreshBackgroundColor: colorScheme.surface,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onInverseSurface),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        titleTextStyle: AppTypography.textTheme.headlineSmall!
            .copyWith(color: colorScheme.onSurface),
        contentTextStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurfaceVariant),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        clipBehavior: Clip.antiAlias,
        dragHandleColor: colorScheme.outlineVariant,
        surfaceTintColor: colorScheme.surfaceTint,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        selectedLabelStyle: AppTypography.textTheme.labelMedium!
            .copyWith(color: colorScheme.primary),
        unselectedLabelStyle: AppTypography.textTheme.labelMedium!
            .copyWith(color: colorScheme.onSurfaceVariant),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTypography.textTheme.bodySmall!
            .copyWith(color: colorScheme.onInverseSurface),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        showDuration: const Duration(milliseconds: 3000),
        waitDuration: const Duration(milliseconds: 500),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
        textStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurface),
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        contentTextStyle: AppTypography.textTheme.bodyMedium!
            .copyWith(color: colorScheme.onSurface),
        elevation: 3,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        textColor: colorScheme.onSurface,
        iconColor: colorScheme.onSurfaceVariant,
        collapsedTextColor: colorScheme.onSurface,
        collapsedIconColor: colorScheme.onSurfaceVariant,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorScheme.primary, width: 3),
        ),
        labelStyle: AppTypography.textTheme.labelLarge,
        unselectedLabelStyle: AppTypography.textTheme.labelLarge,
        dividerColor: colorScheme.outlineVariant,
      ),
    );
  }
}
