import 'package:flutter/material.dart';

import '../../../../domain/quick_access_item.dart';
import '../../../theme/app_theme.dart';
import 'home_assets.dart';
import 'home_dashboard_widgets.dart';

class HomeQuickAccessCard extends StatelessWidget {
  const HomeQuickAccessCard({
    super.key,
    required this.item,
  });

  final QuickAccessItem item;

  @override
  Widget build(BuildContext context) {
    final compact = isCompactWidth(context);

    return SizedBox(
      height: compact ? 182 : 194,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                HomePrototypeAssets.quickAccessBackground(item.icon),
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.26),
                      Colors.black.withValues(alpha: 0.72),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(compact ? 12 : 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.8,
                            fontSize: compact ? 16 : 18,
                          ),
                    ),
                    SizedBox(height: compact ? 8 : 10),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _content(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _content(BuildContext context) {
    switch (item.icon) {
      case 'check':
        return [
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              for (final active in [true, false, true, true, false, true, false])
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active
                        ? AppPalette.primary
                        : const Color(0xFF3A3F45),
                  ),
                  child: active
                      ? const Icon(
                          Icons.check,
                          size: 13,
                          color: Colors.black,
                        )
                      : null,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: ['S', 'T', 'Q', 'Q', 'S', 'S', 'D']
                .map(
                  (label) => Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF848A90),
                            fontSize: 9,
                          ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
          const SizedBox(height: 8),
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFCECECE),
                  fontSize: 13,
                ),
          ),
        ];
      case 'event':
        return [
          Text(
            item.accentLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFBDBDBD),
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Torneio de Duplas',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppPalette.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                '14/20',
                style: TextStyle(color: Color(0xFFBEBEBE)),
              ),
            ],
          ),
        ];
      case 'sports':
        return [
          Text(
            'Última partida',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFBEBEBE),
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Você    Rafael',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFBEBEBE),
                  fontSize: 13,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '6 × 4',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF223913),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Vitória',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppPalette.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ];
      case 'chart':
        return [
          const HomeMiniBarChart(),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '85%',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 28,
                    ),
              ),
              Text(
                'consistência',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: const Color(0xFFC8C8C8),
                    ),
              ),
            ],
          ),
        ];
      case 'ranking':
        return [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '#12',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sua posição',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFFCECECE),
                            ),
                      ),
                      Text(
                        '↑ 3 posições',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppPalette.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ];
      case 'shooting':
        return [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'novas fotos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFCECECE),
                  ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...HomePrototypeAssets.quickAccessAvatars.map(
                (asset) => CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(asset),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.accentLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ];
      case 'clubs':
        return [
          Text(
            '3 clubes ativos',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFCECECE),
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...HomePrototypeAssets.clubAvatars.map(
                (asset) => CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(asset),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  item.accentLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ];
      case 'calendar':
        return [
          Text(
            'Quadra 03 disponível',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFD1D1D1),
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hoje · 18:00–19:00',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              HomeSportChip(label: 'Tennis', highlighted: true),
              HomeSportChip(label: 'Padel'),
            ],
          ),
        ];
      default:
        return [
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFCECECE),
                ),
          ),
        ];
    }
  }
}
