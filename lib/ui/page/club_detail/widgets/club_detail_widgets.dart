import 'package:flutter/material.dart';

import '../../../../domain/club_member.dart';
import '../../../../domain/club_photo.dart';
import '../../../../domain/club_session.dart';
import '../../../theme/app_theme.dart';

class ClubHero extends StatelessWidget {
  const ClubHero({
    super.key,
    required this.imageAsset,
    required this.membersLabel,
    required this.privacyLabel,
    required this.headline,
  });

  final String imageAsset;
  final String membersLabel;
  final String privacyLabel;
  final String headline;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: SizedBox(
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imageAsset, fit: BoxFit.cover),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppPalette.black.withValues(alpha: AppOpacity.scrim),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              left: AppSpacing.giant,
              right: AppSpacing.giant,
              bottom: AppSpacing.giant,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _Pill(label: privacyLabel),
                      const SizedBox(width: AppSpacing.sm),
                      _Pill(label: membersLabel),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    headline,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppPalette.white,
                          fontWeight: FontWeight.w800,
                          fontSize: AppFontSize.headingSm,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppPalette.black.withValues(alpha: AppOpacity.overlay),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppPalette.white,
              fontWeight: FontWeight.w600,
              fontSize: AppFontSize.label,
              letterSpacing: AppLetterSpacing.wideSm,
            ),
      ),
    );
  }
}

class ClubTagRow extends StatelessWidget {
  const ClubTagRow({super.key, required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppPalette.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                  color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                  width: AppStroke.hairline,
                ),
              ),
              child: Text(
                tag,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppPalette.textSecondary,
                      fontSize: AppFontSize.bodySm,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class ClubMembersStrip extends StatelessWidget {
  const ClubMembersStrip({
    super.key,
    required this.title,
    required this.members,
  });

  final String title;
  final List<ClubMember> members;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.titleLg,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: members.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.lg),
            itemBuilder: (context, index) =>
                _MemberTile(member: members[index]),
          ),
        ),
      ],
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.member});

  final ClubMember member;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.surfaceAlt,
              image: member.avatarAsset != null
                  ? DecorationImage(
                      image: AssetImage(member.avatarAsset!),
                      fit: BoxFit.cover,
                    )
                  : null,
              border: Border.all(
                color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                width: AppStroke.hairline,
              ),
            ),
            alignment: Alignment.center,
            child: member.avatarAsset == null
                ? Text(
                    member.initials ?? '·',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPalette.white,
                          fontWeight: FontWeight.w700,
                        ),
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            member.name.split(' ').first,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.white,
                  fontSize: AppFontSize.label,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            member.roleLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppPalette.textHint,
                  fontSize: AppFontSize.caption,
                ),
          ),
        ],
      ),
    );
  }
}

class ClubSessionsList extends StatelessWidget {
  const ClubSessionsList({
    super.key,
    required this.title,
    required this.sessions,
  });

  final String title;
  final List<ClubSession> sessions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.titleLg,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final session in sessions) ...[
          if (session != sessions.first)
            const SizedBox(height: AppSpacing.md),
          _SessionCard(session: session),
        ],
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

  final ClubSession session;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
          width: AppStroke.hairline,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppPalette.primary.withValues(alpha: AppOpacity.medium),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            alignment: Alignment.center,
            child: Text(
              session.dayLabel,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppPalette.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.label,
                    letterSpacing: AppLetterSpacing.wideSm,
                  ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppFontSize.bodyLg,
                      ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '${session.timeLabel} · ${session.locationLabel}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppPalette.textMuted,
                        fontSize: AppFontSize.bodySm,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Text(
            session.capacityLabel,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppPalette.textHint,
                  fontSize: AppFontSize.label,
                ),
          ),
        ],
      ),
    );
  }
}

class ClubPhotoGrid extends StatelessWidget {
  const ClubPhotoGrid({
    super.key,
    required this.title,
    required this.photos,
  });

  final String title;
  final List<ClubPhoto> photos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.titleLg,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Image.asset(
              photos[index].imageAsset,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class ClubRulesList extends StatelessWidget {
  const ClubRulesList({
    super.key,
    required this.title,
    required this.rules,
  });

  final String title;
  final List<String> rules;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.titleLg,
              ),
        ),
        const SizedBox(height: AppSpacing.lg),
        for (final rule in rules) ...[
          if (rule != rules.first) const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPalette.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  rule,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppPalette.textSecondary,
                        fontSize: AppFontSize.bodyLg,
                        height: 1.4,
                      ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class ClubActions extends StatelessWidget {
  const ClubActions({
    super.key,
    required this.joinLabel,
    required this.shareLabel,
    required this.onJoin,
    required this.onShare,
  });

  final String joinLabel;
  final String shareLabel;
  final VoidCallback onJoin;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: AppSize.buttonHeight,
            child: ElevatedButton(
              onPressed: onJoin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primary,
                foregroundColor: AppPalette.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
                elevation: 0,
              ),
              child: Text(
                joinLabel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppPalette.black,
                      fontWeight: FontWeight.w700,
                      fontSize: AppFontSize.titleSm,
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        SizedBox(
          height: AppSize.buttonHeight,
          width: AppSize.buttonHeight,
          child: OutlinedButton(
            onPressed: onShare,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: AppPalette.surfaceAlt,
              side: BorderSide(
                color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                width: AppStroke.hairline,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
            ),
            child: const Icon(
              Icons.share_rounded,
              color: AppPalette.white,
              size: AppIconSize.lg,
            ),
          ),
        ),
      ],
    );
  }
}
