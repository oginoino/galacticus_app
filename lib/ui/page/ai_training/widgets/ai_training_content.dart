import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../domain/ai_training_messages.dart';
import '../../../../domain/ai_training_metric.dart';
import '../../../../domain/ai_training_overview.dart';
import '../../../../domain/ai_training_reference.dart';
import '../../../theme/app_theme.dart';
import 'ai_training_widgets.dart';

enum _AiTrainingLayoutMode {
  referenceFocus,
  cameraFocus,
  split,
}

class AiTrainingContent extends StatefulWidget {
  const AiTrainingContent({
    super.key,
    required this.overview,
    required this.onBackTap,
    required this.onMessage,
  });

  final AiTrainingOverview overview;
  final VoidCallback onBackTap;
  final ValueChanged<String> onMessage;

  @override
  State<AiTrainingContent> createState() => _AiTrainingContentState();
}

class _AiTrainingContentState extends State<AiTrainingContent>
    with WidgetsBindingObserver {
  bool _started = false;
  int _currentStep = 1;
  _AiTrainingLayoutMode _layoutMode = _AiTrainingLayoutMode.referenceFocus;
  CameraController? _controller;
  int _cameraIndex = 0;
  bool _isInitializingCamera = true;
  String? _cameraError;
  static const int _totalSteps = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      controller.dispose();
      _controller = null;
      return;
    }

    if (state == AppLifecycleState.resumed) {
      _initializeCamera(preferredIndex: _cameraIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final reference = widget.overview.references.first;
    final topInset = MediaQuery.viewPaddingOf(context).top;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final backgroundMedia = _layoutMode == _AiTrainingLayoutMode.cameraFocus
        ? _buildCameraMedia()
        : Image.asset(
            reference.imageAsset,
            fit: BoxFit.cover,
          );

    return Stack(
      fit: StackFit.expand,
      children: [
        if (_started && _layoutMode == _AiTrainingLayoutMode.split)
          _AiTrainingSplitLayout(
            referenceMedia: Image.asset(
              reference.imageAsset,
              fit: BoxFit.cover,
            ),
            previewMedia: _buildCameraMedia(),
            previewLabel: widget.overview.previewLabel,
            overviewMessages: widget.overview.messages,
            onTap: _cycleLayoutMode,
          )
        else ...[
          backgroundMedia,
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppPalette.black.withValues(alpha: AppOpacity.rich),
                  AppPalette.primary.withValues(alpha: 0.18),
                  AppPalette.black.withValues(alpha: AppOpacity.overlayStrong),
                ],
              ),
            ),
          ),
        ],
        Positioned.fill(
          child: IgnorePointer(
            child: Center(
              child: Opacity(
                opacity: 0.18,
                child: Image.asset(
                  widget.overview.watermarkAsset,
                  width: AppSize.aiTrainingWatermarkWidth,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AiTrainingHeader(
            eyebrow: widget.overview.eyebrow,
            title: widget.overview.title,
            closeSemantics: widget.overview.closeSemantics,
            onCloseTap: widget.onBackTap,
          ),
        ),
        if (_started)
          Positioned(
            top: topInset + 92,
            left: AppSpacing.page,
            child: AiTrainingProgressCard(
              currentStep: _currentStep,
              totalSteps: _totalSteps,
              title: widget.overview.progressTitle,
              subtitle: widget.overview.progressSubtitle,
            ),
          ),
        Positioned(
          right: AppSpacing.page,
          bottom: bottomInset + AppSpacing.xxl,
          child: _started
              ? _buildTrainingInset(reference)
              : AiTrainingInsetMediaCard(
                  badgeLabel: widget.overview.previewLabel,
                  statusLabel: _cameraStatusLabel(initial: true),
                  media: _buildCameraMedia(),
                  highlighted: false,
                  pulsing: false,
                  onTap: () {},
                ),
        ),
        if (!_started)
          Positioned(
            left: AppSpacing.page,
            right: AppSpacing.page,
            bottom: bottomInset + AppSpacing.page,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: _IdleTrainingPanel(
                key: const ValueKey('idle'),
                popupTitle: widget.overview.instructionTitle,
                logoAsset: widget.overview.assistantLogoAsset,
                instructionBody: widget.overview.instructionBody,
                metrics: widget.overview.metrics,
                buttonLabel: widget.overview.startButtonLabel,
                onButtonTap: _startTraining,
              ),
            ),
          ),
      ],
    );
  }

  void _startTraining() {
    setState(() {
      _started = true;
      _currentStep = 1;
      _layoutMode = _AiTrainingLayoutMode.referenceFocus;
    });
    widget.onMessage(widget.overview.messages.startAction);
  }

  Widget _buildTrainingInset(AiTrainingReference reference) {
    switch (_layoutMode) {
      case _AiTrainingLayoutMode.referenceFocus:
        return AiTrainingInsetMediaCard(
          badgeLabel: widget.overview.messages.recordBadgeLabel,
          statusLabel: widget.overview.messages.switchLayoutHint,
          media: _buildCameraMedia(),
          highlighted: true,
          pulsing: _cameraReady,
          onTap: _cycleLayoutMode,
        );
      case _AiTrainingLayoutMode.cameraFocus:
        return AiTrainingInsetMediaCard(
          badgeLabel: widget.overview.messages.videoBadgeLabel,
          statusLabel: widget.overview.messages.referenceThumbnailLabel,
          media: Image.asset(
            reference.imageAsset,
            fit: BoxFit.cover,
          ),
          highlighted: false,
          pulsing: false,
          onTap: _cycleLayoutMode,
        );
      case _AiTrainingLayoutMode.split:
        return const SizedBox.shrink();
    }
  }

  void _cycleLayoutMode() {
    setState(() {
      switch (_layoutMode) {
        case _AiTrainingLayoutMode.referenceFocus:
          _layoutMode = _AiTrainingLayoutMode.cameraFocus;
          break;
        case _AiTrainingLayoutMode.cameraFocus:
          _layoutMode = _AiTrainingLayoutMode.split;
          break;
        case _AiTrainingLayoutMode.split:
          _layoutMode = _AiTrainingLayoutMode.referenceFocus;
          break;
      }
    });
    widget.onMessage(widget.overview.messages.mediaAction);
  }

  bool get _cameraReady => _controller != null && _controller!.value.isInitialized;

  Future<void> _initializeCamera({int? preferredIndex}) async {
    setState(() {
      _isInitializingCamera = true;
      _cameraError = null;
    });

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _cameraError = widget.overview.messages.cameraUnavailable;
          _isInitializingCamera = false;
        });
        return;
      }

      final requestedIndex = preferredIndex ?? _preferredCameraIndex(cameras);
      _cameraIndex = requestedIndex < 0
          ? 0
          : (requestedIndex >= cameras.length ? cameras.length - 1 : requestedIndex);
      final camera = cameras[_cameraIndex];

      final previous = _controller;
      final controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      _controller = controller;
      if (previous != null) {
        await previous.dispose();
      }
      await controller.initialize();

      if (!mounted) {
        return;
      }

      setState(() {
        _isInitializingCamera = false;
      });
    } on CameraException catch (error) {
      if (!mounted) {
        return;
      }

      final denied = error.code == 'CameraAccessDenied' ||
          error.code == 'CameraAccessDeniedWithoutPrompt' ||
          error.code == 'CameraAccessRestricted';

      setState(() {
        _cameraError = denied
            ? widget.overview.messages.cameraPermissionDenied
            : widget.overview.messages.cameraUnavailable;
        _isInitializingCamera = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _cameraError = widget.overview.messages.cameraUnavailable;
        _isInitializingCamera = false;
      });
    }
  }

  int _preferredCameraIndex(List<CameraDescription> cameras) {
    final frontIndex = cameras.indexWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    return frontIndex >= 0 ? frontIndex : 0;
  }

  String _cameraStatusLabel({bool initial = false}) {
    if (_cameraReady) {
      return initial
          ? widget.overview.messages.cameraReadyLabel
          : widget.overview.messages.switchLayoutHint;
    }

    if (_isInitializingCamera) {
      return widget.overview.messages.cameraInitializingLabel;
    }

    return _cameraError ?? widget.overview.messages.cameraUnavailable;
  }

  Widget _buildCameraMedia() {
    if (_cameraReady) {
      final controller = _controller!;
      final size = controller.value.previewSize;

      if (size == null) {
        return Container(color: AppPalette.black);
      }

      return ClipRect(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: size.height,
            height: size.width,
            child: CameraPreview(controller),
          ),
        ),
      );
    }

    return ColoredBox(
      color: AppPalette.black,
      child: Center(
        child: Padding(
          padding: AppInsets.cardPaddingMd,
          child: Text(
            _cameraStatusLabel(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPalette.textMuted,
                  fontSize: AppFontSize.body,
                ),
          ),
        ),
      ),
    );
  }
}

class _IdleTrainingPanel extends StatelessWidget {
  const _IdleTrainingPanel({
    super.key,
    required this.popupTitle,
    required this.logoAsset,
    required this.instructionBody,
    required this.metrics,
    required this.buttonLabel,
    required this.onButtonTap,
  });

  final String popupTitle;
  final String logoAsset;
  final String instructionBody;
  final List<AiTrainingMetric> metrics;
  final String buttonLabel;
  final VoidCallback onButtonTap;

  @override
  Widget build(BuildContext context) {
    return AiTrainingAssistantPopup(
      logoAsset: logoAsset,
      title: popupTitle,
      child: AiTrainingInstructionCard(
        body: instructionBody,
        metrics: metrics,
        buttonLabel: buttonLabel,
        onTap: onButtonTap,
      ),
    );
  }
}

class _AiTrainingSplitLayout extends StatelessWidget {
  const _AiTrainingSplitLayout({
    required this.referenceMedia,
    required this.previewMedia,
    required this.previewLabel,
    required this.overviewMessages,
    required this.onTap,
  });

  final Widget referenceMedia;
  final Widget previewMedia;
  final String previewLabel;
  final AiTrainingMessages overviewMessages;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _AiTrainingSplitPane(
            media: referenceMedia,
            badgeLabel: overviewMessages.videoBadgeLabel,
            caption: overviewMessages.referencePaneLabel,
            onTap: onTap,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Expanded(
          child: _AiTrainingSplitPane(
            media: previewMedia,
            badgeLabel: overviewMessages.recordBadgeLabel,
            caption: previewLabel,
            onTap: onTap,
            highlighted: true,
          ),
        ),
      ],
    );
  }
}

class _AiTrainingSplitPane extends StatelessWidget {
  const _AiTrainingSplitPane({
    required this.media,
    required this.badgeLabel,
    required this.caption,
    required this.onTap,
    this.highlighted = false,
  });

  final Widget media;
  final String badgeLabel;
  final String caption;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          media,
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppPalette.black.withValues(alpha: AppOpacity.lg),
                  AppPalette.black.withValues(alpha: AppOpacity.overlay),
                ],
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.page,
            left: AppSpacing.page,
            child: _AiTrainingSplitTag(
              label: badgeLabel,
              highlighted: highlighted,
            ),
          ),
          Positioned(
            left: AppSpacing.page,
            bottom: AppSpacing.page,
            child: Text(
              caption,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppPalette.white,
                    fontWeight: FontWeight.w700,
                    fontSize: AppFontSize.titleSm,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiTrainingSplitTag extends StatelessWidget {
  const _AiTrainingSplitTag({
    required this.label,
    this.highlighted = false,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.pillPadding,
      decoration: BoxDecoration(
        color: highlighted
            ? AppPalette.primary
            : AppPalette.white.withValues(alpha: AppOpacity.xxs),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: highlighted ? AppPalette.black : AppPalette.white,
          fontWeight: FontWeight.w700,
          fontSize: AppFontSize.labelLg,
        ),
      ),
    );
  }
}
