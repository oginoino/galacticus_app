import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppPalette {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const background = Color(0xFF050708);
  static const backgroundLight = Color(0xFFF6F8F3);
  static const surface = Color(0xFF101315);
  static const surfaceAlt = Color(0xFF191D20);
  static const card = Color(0xFF14181B);
  static const border = Color(0xFF262C31);
  static const primary = Color(0xFFB7F36B);
  static const primaryLight = Color(0xFF7BCB31);
  static const primaryStrong = Color(0xFFC8FF7A);
  static const secondary = Color(0xFF8EA4FF);
  static const textPrimary = Color(0xFFF5F7FA);
  static const textSecondary = Color(0xFFB2BAC3);
  static const textMuted = Color(0xFFBFC3C8);
  static const textSoft = Color(0xFFBBBBBB);
  static const textNeutral = Color(0xFFBDBDBD);
  static const textNeutralAlt = Color(0xFFBEBEBE);
  static const textTertiary = Color(0xFFAAAAAA);
  static const textQuaternary = Color(0xFFB8B8B8);
  static const textMeta = Color(0xFF8E949A);
  static const textStats = Color(0xFFB0B0B0);
  static const textHint = Color(0xFF848A90);
  static const textAxis = Color(0xFF82888F);
  static const textDim = Color(0xFF7D838B);
  static const textCalendar = Color(0xFF696F76);
  static const textGlass = Color(0xFFCECECE);
  static const textEvent = Color(0xFFD5D5D5);
  static const textCalendarLight = Color(0xFFD1D1D1);
  static const successDark = Color(0xFF223913);
  static const successSoft = Color(0xFF253413);
  static const successHighlight = Color(0xFF31401D);
  static const badgeLocation = Color(0xFF182715);
  static const surfaceDeep = Color(0xFF111316);
  static const glassDark = Color(0x6B2A2E34);
  static const glassIcon = Color(0xFF0D1218);
  static const glassBorder = Color(0xFF171A1E);
  static const assistantStart = Color(0xFF022900);
  static const assistantEnd = Color(0xFF113500);
  static const heroOverlayWarm = Color(0xFF7A3400);
  static const heroOverlayDark = Color(0xFF101010);
  static const calendarDark = Color(0xFF1A1D21);
  static const bronze = Color(0xFFEA8A00);
  static const silver = Color(0xFFA7A7A7);
  static const gold = Color(0xFFF7C934);
  static const warning = Color(0xFFF8C55C);
  static const warningDark = Color(0xFF5F4410);
  static const inactiveDot = Color(0xFF3A3F45);
  static const chipInactive = Color(0xFF2B2B2B);
  static const chartBarA = Color(0xFF6B8D3B);
  static const chartBarB = Color(0xFF6C8F3D);
  static const chartBarC = Color(0xFF89B84A);
}

abstract final class AppOpacity {
  static const none = 0.0;
  static const xxs = 0.03;
  static const xs = 0.04;
  static const sm = 0.05;
  static const md = 0.06;
  static const lg = 0.08;
  static const xl = 0.10;
  static const xxl = 0.12;
  static const xxxl = 0.13;
  static const soft = 0.14;
  static const medium = 0.16;
  static const strong = 0.18;
  static const stronger = 0.26;
  static const emphasis = 0.30;
  static const heavy = 0.58;
  static const overlay = 0.72;
  static const overlayStrong = 0.75;
  static const scrim = 0.82;
}

abstract final class AppSpacing {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 6.0;
  static const md = 8.0;
  static const lg = 10.0;
  static const xl = 12.0;
  static const xxl = 14.0;
  static const xxxl = 16.0;
  static const huge = 18.0;
  static const giant = 20.0;
  static const section = 22.0;
  static const page = 24.0;
  static const sectionLg = 26.0;
  static const screen = 16.0;
  static const bottomContent = 124.0;
}

abstract final class AppRadius {
  static const xs = 4.0;
  static const sm = 6.0;
  static const md = 8.0;
  static const lg = 10.0;
  static const xl = 12.0;
  static const xxl = 14.0;
  static const xxxl = 18.0;
  static const button = 20.0;
  static const card = 28.0;
  static const pill = 999.0;
}

abstract final class AppStroke {
  static const hairline = 1.0;
  static const thin = 1.2;
}

abstract final class AppBlur {
  static const navGlass = 22.0;
}

abstract final class AppShadow {
  static const cardBlur = 24.0;
  static const cardOffsetY = 12.0;
  static const navBlur = 28.0;
  static const navOffsetY = 14.0;
}

abstract final class AppIconSize {
  static const xxs = 10.0;
  static const xs = 12.0;
  static const sm = 14.0;
  static const md = 16.0;
  static const lg = 18.0;
  static const xl = 20.0;
  static const xxl = 22.0;
  static const xxxl = 24.0;
  static const huge = 26.0;
  static const giant = 28.0;
  static const giantPlus = 30.0;
  static const play = 34.0;
}

abstract final class AppFontSize {
  static const caption = 9.0;
  static const label = 10.0;
  static const labelLg = 11.0;
  static const bodySm = 12.0;
  static const body = 13.0;
  static const bodyLg = 14.0;
  static const titleSm = 15.0;
  static const title = 16.0;
  static const titleLg = 17.0;
  static const headingSm = 18.0;
  static const heading = 20.0;
  static const metric = 28.0;
  static const displaySm = 30.0;
  static const display = 38.0;
}

abstract final class AppLetterSpacing {
  static const tightXs = -0.3;
  static const tightSm = -0.4;
  static const tightMd = -0.5;
  static const tightLg = -0.6;
  static const tightXl = -0.8;
  static const display = -1.2;
  static const wideSm = 1.0;
  static const wideMd = 1.6;
}

abstract final class AppSize {
  static const navBarHeight = 82.0;
  static const navGlow = 118.0;
  static const navCenterButton = 44.0;
  static const navCenterGap = 72.0;
  static const navBottomPadding = 8.0;
  static const navBottomPaddingSafe = 2.0;
  static const avatar = 54.0;
  static const avatarLg = 58.0;
  static const statusDot = 10.0;
  static const progressHeight = 8.0;
  static const bookingIcon = 42.0;
  static const bookingIconCompact = 40.0;
  static const assistantIcon = 50.0;
  static const assistantIconCompact = 46.0;
  static const heroHeight = 224.0;
  static const heroHeightCompact = 204.0;
  static const lessonCardWidth = 176.0;
  static const lessonCardWidthCompact = 162.0;
  static const inviteCardWidth = 226.0;
  static const inviteCardWidthCompact = 208.0;
  static const quickAccessCardHeight = 194.0;
  static const quickAccessCardHeightCompact = 182.0;
  static const exploreCardWidth = 210.0;
  static const ringSmall = 5.0;
  static const badgeSquare = 28.0;
}

abstract final class AppInsets {
  static const screen = EdgeInsets.symmetric(horizontal: AppSpacing.screen);
  static const glowCard = EdgeInsets.all(AppSpacing.giant);
  static const sectionAction = EdgeInsets.symmetric(
    horizontal: AppSpacing.xxs,
    vertical: AppSpacing.xs,
  );
  static const navBar = EdgeInsets.symmetric(
    horizontal: AppSpacing.xxxl,
    vertical: AppSpacing.md,
  );
}

class AppTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppPalette.background,
      colorScheme: const ColorScheme.dark(
        primary: AppPalette.primary,
        secondary: AppPalette.secondary,
        surface: AppPalette.surface,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppPalette.textPrimary,
        displayColor: AppPalette.textPrimary,
      ),
      cardColor: AppPalette.card,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppPalette.surfaceAlt,
        contentTextStyle: GoogleFonts.inter(
          color: AppPalette.textPrimary,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPalette.textPrimary,
        ),
      ),
    );
  }

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppPalette.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppPalette.primaryLight,
        secondary: AppPalette.secondary,
        surface: AppPalette.white,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppPalette.black.withValues(alpha: 0.87),
        contentTextStyle: GoogleFonts.inter(
          color: AppPalette.white,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
