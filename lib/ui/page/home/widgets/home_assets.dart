import 'package:flutter/material.dart';

abstract final class HomePrototypeAssets {
  static const basePath = 'assets/images/prototype';

  static const lessonImages = [
    '$basePath/lesson-saque-slice.jpg',
    '$basePath/lesson-forehand-topspin.jpg',
    '$basePath/lesson-backhand-iniciante.jpg',
    '$basePath/lesson-voleio.jpg',
    '$basePath/lesson-smash.jpg',
  ];

  static const exploreImages = [
    '$basePath/social-tournament.jpg',
    '$basePath/coach-marcos.jpg',
    '$basePath/hero-court.jpg',
  ];

  static String lessonByIndex(int index) {
    return lessonImages[index % lessonImages.length];
  }

  static String exploreByIndex(int index) {
    return exploreImages[index % exploreImages.length];
  }

  static String leaderboardAvatar(String name) {
    if (name.contains('Gabriel')) {
      return '$basePath/avatar-gabe.jpg';
    }
    if (name.contains('Leonardo')) {
      return '$basePath/avatar-leo.jpg';
    }
    return '$basePath/paulo.jpg';
  }

  static String inviteAvatar(String name) {
    if (name.contains('Sofia')) {
      return '$basePath/avatar-sofia.jpg';
    }
    if (name.contains('Gabriel')) {
      return '$basePath/avatar-gabe.jpg';
    }
    return '$basePath/avatar-leo.jpg';
  }

  static String? calendarImage(String label, bool isActive) {
    if (!isActive) {
      return null;
    }

    return switch (label) {
      '6' => '$basePath/cal-workout-1.jpg',
      '10' => '$basePath/cal-workout-2.jpg',
      '14' => '$basePath/cal-workout-3.jpg',
      '22' => '$basePath/cal-workout-2.jpg',
      '28' => '$basePath/cal-workout-3.jpg',
      '29' => '$basePath/hero-court.jpg',
      '31' => '$basePath/cal-workout-1.jpg',
      _ => null,
    };
  }

  static String quickAccessBackground(String icon) {
    return switch (icon) {
      'check' => '$basePath/widget-checkin.jpg',
      'event' => '$basePath/widget-eventos.jpg',
      'sports' => '$basePath/widget-partidas.jpg',
      'chart' => '$basePath/widget-progresso.jpg',
      'ranking' => '$basePath/widget-ranking.jpg',
      'shooting' => '$basePath/widget-shooting.jpg',
      'clubs' => '$basePath/widget-clubes.jpg',
      'calendar' => '$basePath/widget-reservar.jpg',
      _ => '$basePath/widget-shooting.jpg',
    };
  }

  static const quickAccessAvatars = [
    '$basePath/avatar-gabe.jpg',
    '$basePath/avatar-sofia.jpg',
    '$basePath/avatar-leo.jpg',
    '$basePath/paulo.jpg',
  ];

  static const clubAvatars = [
    '$basePath/paulo.jpg',
    '$basePath/avatar-sofia.jpg',
    '$basePath/avatar-leo.jpg',
  ];
}

bool isCompactWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width <= 393;
}
