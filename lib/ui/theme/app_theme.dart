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
  static const iconSubtle = Color(0xFF9BA1A7);
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
  static const danger = Color(0xFFE6604E);
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
  static const quarter = 0.25;
  static const stronger = 0.26;
  static const emphasis = 0.30;
  static const accent = 0.38;
  static const half = 0.5;
  static const heavy = 0.58;
  static const rich = 0.6;
  static const text = 0.66;
  static const snackbar = 0.87;
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
  static const cardXl = 32.0;
  static const pill = 999.0;
}

abstract final class AppStroke {
  static const hairline = 1.0;
  static const thin = 1.2;
  static const thick = 2.0;
}

abstract final class AppBlur {
  static const navGlass = 22.0;
}

abstract final class AppMotion {
  static const assistantLogoPulseMinScale = 0.98;
  static const assistantLogoPulseMaxScale = 1.04;
  static const assistantLogoPulseDurationMs = 2000;
  static const assistantLogoRotateDurationMs = 9000;
  static const assistantScreenGlowDurationMs = 3600;
  static const checkinCapturePulseDurationMs = 1800;
  static const aiTrainingPreviewPulseDurationMs = 1800;
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
  static const displayMd = 42.0;
  static const displayLg = 44.0;
  static const metricLg = 36.0;
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
  static const headerActionButton = 40.0;
  static const bottomSheetHandleWidth = 40.0;
  static const bottomSheetHandleHeight = 4.0;
  static const authBrandLogo = 84.0;
  static const navBarHeight = 82.0;
  static const navGlow = 118.0;
  static const navCenterButton = 44.0;
  static const navCenterGap = 72.0;
  static const navBottomPadding = 4.0;
  static const navBottomPaddingSafe = 8.0;
  static const avatar = 54.0;
  static const avatarLg = 58.0;
  static const statusDot = 10.0;
  static const progressHeight = 8.0;
  static const bookingIcon = 42.0;
  static const bookingIconCompact = 40.0;
  static const bookingButtonWidth = 104.0;
  static const bookingButtonWidthCompact = 92.0;
  static const workoutLeading = 48.0;
  static const buttonHeight = 52.0;
  static const buttonHeightCompact = 46.0;
  static const assistantIcon = 50.0;
  static const assistantIconCompact = 46.0;
  static const assistantInnerPadding = 9.0;
  static const heroHeight = 224.0;
  static const heroHeightCompact = 204.0;
  static const heroIndicator = 18.0;
  static const heroIndicatorCompact = 14.0;
  static const heroOverlayPadding = 16.0;
  static const heroOverlayPaddingCompact = 12.0;
  static const heroTitleWidthFactor = 0.62;
  static const heroTitleWidthFactorCompact = 0.58;
  static const heroLineHeight = 0.95;
  static const lessonCardWidth = 176.0;
  static const lessonCardWidthCompact = 162.0;
  static const lessonPlayButton = 52.0;
  static const lessonPlayButtonCompact = 46.0;
  static const inviteCardWidth = 226.0;
  static const inviteCardWidthCompact = 208.0;
  static const inviteAvatarRadius = 24.0;
  static const inviteAvatarRadiusCompact = 20.0;
  static const quickAccessCardHeight = 194.0;
  static const quickAccessCardHeightCompact = 182.0;
  static const exploreCardWidth = 210.0;
  static const lessonListHeight = 176.0;
  static const lessonListHeightCompact = 170.0;
  static const exploreListHeight = 114.0;
  static const exploreListHeightCompact = 122.0;
  static const inviteListHeight = 176.0;
  static const inviteListHeightCompact = 184.0;
  static const leaderboardAvatarRadius = 20.0;
  static const quickAccessAvatarRadius = 14.0;
  static const navCircle = 28.0;
  static const chartHeight = 72.0;
  static const miniChartHeight = 34.0;
  static const ringSmall = 5.0;
  static const badgeSquare = 28.0;
  static const chartBarWidthRadius = 1.0;
  static const feedLogoSize = 24.0;
  static const feedHeaderAvatar = 48.0;
  static const feedStoryRingSize = 82.0;
  static const feedStoryRingSizeCompact = 74.0;
  static const feedStoryAvatarSize = 70.0;
  static const feedStoryAvatarSizeCompact = 62.0;
  static const feedStoryListHeight = 114.0;
  static const feedStoryAddBadge = 24.0;
  static const feedFilterHeight = 50.0;
  static const feedFilterHeightCompact = 46.0;
  static const feedFilterIconButton = 50.0;
  static const feedTopActionButton = 40.0;
  static const feedPostHeaderAvatar = 44.0;
  static const feedPostImageHeight = 286.0;
  static const feedPostImageHeightCompact = 254.0;
  static const feedPostActionIcon = 20.0;
  static const feedPostFloatingAvatar = 44.0;
  static const feedPostMetricBadgeHeight = 72.0;
  static const feedPostMetricBadgeHeightCompact = 66.0;
  static const feedPostCommentBadge = 34.0;
  static const feedWorkoutCardHeight = 430.0;
  static const feedWorkoutCardHeightCompact = 390.0;
  static const feedWorkoutMetricCardHeight = 74.0;
  static const feedWorkoutMetricCardHeightCompact = 68.0;
  static const feedWorkoutMiniMetricHeight = 84.0;
  static const feedWorkoutAvatarRing = 50.0;
  static const feedWorkoutCommentAvatar = 28.0;
  static const feedWorkoutBackdropInset = 42.0;
  static const feedWorkoutBackdropTop = 20.0;
  static const feedWorkoutBackdropBottom = 36.0;
  static const feedWorkoutNeonInset = 72.0;
  static const feedWorkoutNeonBottom = 134.0;
  static const feedWorkoutOrbitTop = 128.0;
  static const feedWorkoutOrbitRight = 54.0;
  static const feedWorkoutOrbitLarge = 110.0;
  static const feedWorkoutOrbitInnerTop = 148.0;
  static const feedWorkoutOrbitInnerRight = 74.0;
  static const feedWorkoutOrbitInnerSize = 70.0;
  static const feedWorkoutGridSpacing = 18.0;
  static const feedWorkoutGridDot = 0.8;
  static const communitiesHeaderAvatar = 44.0;
  static const communitiesTopIcon = 40.0;
  static const communitiesSearchHeight = 44.0;
  static const communitiesOwnedCardWidth = 132.0;
  static const communitiesOwnedCardHeight = 144.0;
  static const communitiesOwnedListHeight = 156.0;
  static const communitiesChipHeight = 36.0;
  static const communitiesDiscoverImageHeight = 98.0;
  static const communitiesDiscoverCardRadius = 22.0;
  static const communitiesDiscoverAvatar = 22.0;
  static const communitiesDiscoverButtonHeight = 40.0;
  static const communitiesDiscoverButtonHeightCompact = 36.0;
  static const communitiesSectionDivider = 2.0;
  static const communitiesDiscoverGridAspectRatio = 0.58;
  static const rankingCategoryHeight = 34.0;
  static const rankingPodiumAvatar = 42.0;
  static const rankingPodiumCardWidth = 82.0;
  static const rankingPodiumCardHeight = 62.0;
  static const rankingPodiumCardHeightWinner = 86.0;
  static const rankingListAvatar = 36.0;
  static const rankingPositionWidth = 28.0;
  static const profileHeroHeight = 388.0;
  static const profileBackButton = 40.0;
  static const profileAvatar = 84.0;
  static const profileAvatarBorder = 88.0;
  static const profileVerifiedIcon = 22.0;
  static const profileSocialButton = 38.0;
  static const profileTabHeight = 36.0;
  static const profileGalleryRadius = 24.0;
  static const profileGalleryAspectRatio = 0.82;
  static const notificationsLeading = 40.0;
  static const notificationsAvatar = 40.0;
  static const notificationsUnreadDot = 7.0;
  static const bookingToggleHeight = 42.0;
  static const bookingHeroHeight = 248.0;
  static const bookingDateCardWidth = 72.0;
  static const bookingDateCardHeight = 64.0;
  static const bookingTimeChipHeight = 38.0;
  static const assistantStatusHeight = 28.0;
  static const assistantHeroLogo = 84.0;
  static const assistantPromptHeight = 52.0;
  static const assistantInputHeight = 52.0;
  static const assistantSendButton = 36.0;
  static const assistantHeroTopGap = 76.0;
  static const assistantPromptTopGap = 44.0;
  static const assistantBottomSpacer = 140.0;
  static const checkinTopAction = 40.0;
  static const checkinFilterHeight = 44.0;
  static const checkinFilterWidth = 44.0;
  static const checkinCaptureOuter = 74.0;
  static const checkinCaptureInner = 62.0;
  static const checkinSecondaryAction = 54.0;
  static const checkinFilterBottomOffset = 132.0;
  static const lessonsHeroHeight = 334.0;
  static const lessonsFeaturedPlay = 82.0;
  static const lessonsTrackCardWidth = 148.0;
  static const lessonsTrackCardHeight = 220.0;
  static const lessonsUpcomingThumbWidth = 94.0;
  static const lessonsUpcomingThumbHeight = 84.0;
  static const agendaEventCardHeight = 140.0;
  static const agendaMatchAvatar = 42.0;
  static const aiTrainingPreviewWidth = 106.0;
  static const aiTrainingPreviewHeight = 126.0;
  static const aiTrainingReferenceCardWidth = 156.0;
  static const aiTrainingReferenceCardHeight = 116.0;
  static const aiTrainingProgressWidth = 184.0;
  static const aiTrainingWatermarkWidth = 260.0;
  static const aiTrainingStartedPanelRightInset = 132.0;
  static const lessonsCoachAvatarRadius = 18.0;
  static const lessonsUpcomingPlayButton = 34.0;
  static const checkinFilterBarHeight = 78.0;
  static const checkinVariantDotsHeight = 8.0;
  static const checkinVariantDot = 6.0;
  static const checkinVariantDotActive = 18.0;
}

abstract final class AppChartHeights {
  static const weekly = [28.0, 42.0, 20.0, 52.0, 36.0, 58.0, 46.0];
  static const mini = [18.0, 26.0, 14.0, 24.0, 20.0, 28.0, 24.0];
}

abstract final class AppHeroLayout {
  static const top = 22.0;
  static const topCompact = 16.0;
  static const lineX = 0.48;
  static const lineTop = 0.16;
  static const lineBottom = 0.86;
  static const baselineY = 0.62;
}

abstract final class AppInsets {
  static const screen = EdgeInsets.symmetric(horizontal: AppSpacing.screen);
  static const glowCard = EdgeInsets.all(AppSpacing.giant);
  static const pageHorizontal = EdgeInsets.symmetric(horizontal: AppSpacing.page);
  static const sectionAction = EdgeInsets.symmetric(
    horizontal: AppSpacing.xxs,
    vertical: AppSpacing.xs,
  );
  static const navBar = EdgeInsets.symmetric(
    horizontal: AppSpacing.xxxl,
    vertical: AppSpacing.md,
  );
  static const feedPostHeader = EdgeInsets.fromLTRB(
    AppSpacing.huge,
    AppSpacing.huge,
    AppSpacing.huge,
    AppSpacing.xxxl,
  );
  static const feedPostBody = EdgeInsets.fromLTRB(
    AppSpacing.page,
    AppSpacing.xl,
    AppSpacing.page,
    AppSpacing.page,
  );
  static const feedPostBadge = EdgeInsets.symmetric(
    horizontal: AppSpacing.xxl,
    vertical: AppSpacing.sm,
  );
  static const feedPostMediaOverlay = EdgeInsets.all(AppSpacing.page);
  static const feedWorkoutCardMargin = EdgeInsets.zero;
  static const feedWorkoutCardContent = EdgeInsets.fromLTRB(
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
  );
  static const feedWorkoutMetric = EdgeInsets.symmetric(
    horizontal: AppSpacing.giant,
    vertical: AppSpacing.md,
  );
  static const feedWorkoutMetricCompact = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.xs,
  );
  static const feedWorkoutMetricBox = EdgeInsets.all(AppSpacing.xxl);
  static const feedWorkoutBadge = EdgeInsets.symmetric(
    horizontal: AppSpacing.xxl,
    vertical: AppSpacing.giant,
  );
  static const communitiesSearch = EdgeInsets.symmetric(
    horizontal: AppSpacing.giant,
  );
  static const communitiesOwnedCardOverlay = EdgeInsets.all(AppSpacing.giant);
  static const communitiesDiscoverCardBody = EdgeInsets.fromLTRB(
    AppSpacing.giant,
    AppSpacing.giant,
    AppSpacing.giant,
    AppSpacing.giant,
  );
  static const communitiesDiscoverCardBodyCompact = EdgeInsets.fromLTRB(
    AppSpacing.xl,
    AppSpacing.xl,
    AppSpacing.xl,
    AppSpacing.xl,
  );
  static const communitiesDiscoverButton = EdgeInsets.symmetric(
    horizontal: AppSpacing.giant,
    vertical: AppSpacing.md,
  );
  static const profileHeroOverlay = EdgeInsets.fromLTRB(
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
  );
  static const profileContent = EdgeInsets.fromLTRB(
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.bottomContent,
  );
  static const profileTab = EdgeInsets.symmetric(
    horizontal: AppSpacing.page,
  );
  static const notificationsPage = EdgeInsets.fromLTRB(
    AppSpacing.page,
    0,
    AppSpacing.page,
    AppSpacing.bottomContent,
  );
  static const notificationsItem = EdgeInsets.symmetric(
    vertical: AppSpacing.xl,
  );
  static const bookingPage = EdgeInsets.fromLTRB(
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.bottomContent,
  );
  static const bookingSection = EdgeInsets.only(top: AppSpacing.page);
  static const bookingHeroOverlay = EdgeInsets.fromLTRB(
    AppSpacing.giant,
    AppSpacing.giant,
    AppSpacing.giant,
    AppSpacing.giant,
  );
  static const assistantPage = EdgeInsets.fromLTRB(
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
  );
  static const homePage = EdgeInsets.fromLTRB(
    AppSpacing.screen,
    0,
    AppSpacing.screen,
    AppSpacing.bottomContent,
  );
  static const feedPage = EdgeInsets.fromLTRB(
    AppSpacing.screen,
    0,
    AppSpacing.screen,
    AppSpacing.bottomContent,
  );
  static const communitiesPage = EdgeInsets.fromLTRB(
    AppSpacing.screen,
    0,
    AppSpacing.screen,
    AppSpacing.bottomContent,
  );
  static const rankingPage = EdgeInsets.fromLTRB(
    AppSpacing.page,
    0,
    AppSpacing.page,
    AppSpacing.bottomContent,
  );
  static const assistantPrompt = EdgeInsets.symmetric(
    horizontal: AppSpacing.giant,
  );
  static const assistantInput = EdgeInsets.symmetric(
    horizontal: AppSpacing.giant,
  );
  static const checkinPage = EdgeInsets.fromLTRB(
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
    AppSpacing.page,
  );
  static const lessonsPage = EdgeInsets.fromLTRB(
    AppSpacing.page,
    0,
    AppSpacing.page,
    AppSpacing.bottomContent,
  );
  static const agendaPage = EdgeInsets.fromLTRB(
    AppSpacing.page,
    0,
    AppSpacing.page,
    AppSpacing.bottomContent,
  );
  static const cardPaddingSm = EdgeInsets.all(AppSpacing.md);
  static const cardPaddingMd = EdgeInsets.all(AppSpacing.lg);
  static const cardPaddingLg = EdgeInsets.all(AppSpacing.xl);
  static const rankingPodiumCardPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.sm,
    vertical: AppSpacing.xs,
  );
  static const pillPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.sm,
    vertical: AppSpacing.xs,
  );
  static const pillPaddingCompact = EdgeInsets.symmetric(
    horizontal: AppSpacing.xs,
    vertical: AppSpacing.xxs,
  );
  static const actionChipPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
    vertical: AppSpacing.sm,
  );
}

abstract final class AppResponsiveInsets {
  static EdgeInsets overlayTopBar(double topInset) => EdgeInsets.fromLTRB(
        AppSpacing.page,
        topInset + AppSpacing.page,
        AppSpacing.page,
        0,
      );

  static EdgeInsets screenTopBar(
    double topInset, {
    double horizontal = AppSpacing.screen,
    double extraTop = AppSpacing.lg,
    double bottom = 0,
  }) =>
      EdgeInsets.fromLTRB(
        horizontal,
        topInset + extraTop,
        horizontal,
        bottom,
      );

  static EdgeInsets overlayBottomBar(double bottomInset) => EdgeInsets.fromLTRB(
        AppSpacing.page,
        0,
        AppSpacing.page,
        bottomInset + AppSpacing.page,
      );

  static EdgeInsets listItemGap(bool isLast) => EdgeInsets.only(
        bottom: isLast ? 0 : AppSpacing.xl,
      );
}

abstract final class AppTextStyles {
  static TextStyle heading(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: AppFontSize.heading,
            letterSpacing: AppLetterSpacing.tightSm,
          );

  static TextStyle brandTitle(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: AppLetterSpacing.tightLg,
          );

  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: AppFontSize.bodyLg,
          );

  static TextStyle bodyLargeSecondary(BuildContext context) =>
      bodyLarge(context).copyWith(color: AppPalette.textSecondary);

  static TextStyle bodyMediumSecondary(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppPalette.textSecondary,
            fontSize: AppFontSize.bodyLg,
          );

  static TextStyle formLabel(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppPalette.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: AppFontSize.labelLg,
            letterSpacing: AppLetterSpacing.wideSm,
          );

  static TextStyle dividerLabel(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!.copyWith(
            color: AppPalette.textHint,
            fontWeight: FontWeight.w500,
            letterSpacing: AppLetterSpacing.wideSm,
          );

  static TextStyle buttonPrimary(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppPalette.black,
            fontWeight: FontWeight.w700,
            fontSize: AppFontSize.titleLg,
          );

  static TextStyle buttonSocial(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppPalette.white,
            fontWeight: FontWeight.w600,
            fontSize: AppFontSize.titleSm,
          );

  static TextStyle inputText(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppPalette.white,
            fontSize: AppFontSize.titleSm,
          );

  static TextStyle inputHint(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppPalette.textHint,
            fontSize: AppFontSize.titleSm,
          );

  static TextStyle errorText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppPalette.danger,
            fontSize: AppFontSize.labelLg,
          );

  static TextStyle linkAction(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppPalette.primary,
            fontWeight: FontWeight.w700,
            fontSize: AppFontSize.bodyLg,
          );

  static TextStyle linkSecondary(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppPalette.primary,
            fontWeight: FontWeight.w600,
            fontSize: AppFontSize.bodyLg,
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
        backgroundColor: AppPalette.black.withValues(alpha: AppOpacity.snackbar),
        contentTextStyle: GoogleFonts.inter(
          color: AppPalette.white,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
