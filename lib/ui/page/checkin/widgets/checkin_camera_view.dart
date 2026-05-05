import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../domain/checkin_overlay.dart';
import '../../../../domain/checkin_overview.dart';
import '../../../components/checkin_overlay_view.dart';
import '../../../theme/app_theme.dart';
import 'checkin_widgets.dart';

class CheckinCameraView extends StatefulWidget {
  const CheckinCameraView({
    super.key,
    required this.overview,
    required this.onBackTap,
    required this.onMessage,
  });

  final CheckinOverview overview;
  final VoidCallback onBackTap;
  final ValueChanged<String> onMessage;

  @override
  State<CheckinCameraView> createState() => _CheckinCameraViewState();
}

class _CheckinCameraViewState extends State<CheckinCameraView>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = const [];
  int _selectedFilterIndex = 0;
  int _cameraIndex = 0;
  bool _flashEnabled = false;
  bool _isInitializingCamera = true;
  bool _isCapturing = false;
  String? _cameraError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _selectedFilterIndex = widget.overview.filters.indexWhere((item) => item.isSelected);
    if (_selectedFilterIndex < 0) {
      _selectedFilterIndex = 0;
    }
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

  Future<void> _initializeCamera({int? preferredIndex}) async {
    setState(() {
      _isInitializingCamera = true;
      _cameraError = null;
    });

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _cameras = const [];
          _cameraError = widget.overview.messages.cameraUnavailable;
          _isInitializingCamera = false;
        });
        return;
      }

      _cameras = cameras;
      final requestedIndex = preferredIndex ?? _cameraIndex;
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
      await controller.setFlashMode(FlashMode.off);

      if (!mounted) {
        return;
      }

      setState(() {
        _flashEnabled = false;
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

  Future<void> _toggleFlash() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      widget.onMessage(widget.overview.messages.cameraUnavailable);
      return;
    }

    try {
      final enabled = !_flashEnabled;
      await controller.setFlashMode(enabled ? FlashMode.torch : FlashMode.off);
      if (!mounted) {
        return;
      }
      setState(() => _flashEnabled = enabled);
    } catch (_) {
      widget.onMessage(widget.overview.messages.cameraUnavailable);
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2) {
      widget.onMessage(widget.overview.messages.cameraUnavailable);
      return;
    }

    final nextIndex = (_cameraIndex + 1) % _cameras.length;
    await _initializeCamera(preferredIndex: nextIndex);
  }

  CheckinOverlay? get _activeOverlay {
    if (_selectedFilterIndex < 0 ||
        _selectedFilterIndex >= widget.overview.filters.length) {
      return null;
    }
    return widget.overview.filters[_selectedFilterIndex].overlay;
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      widget.onMessage(_cameraError ?? widget.overview.messages.cameraUnavailable);
      return;
    }

    if (_isCapturing) {
      return;
    }

    setState(() => _isCapturing = true);
    try {
      await controller.takePicture();
      widget.onMessage(widget.overview.messages.captureSuccess);
    } catch (_) {
      widget.onMessage(widget.overview.messages.captureError);
    } finally {
      if (mounted) {
        setState(() => _isCapturing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final previewReady = controller != null && controller.value.isInitialized;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (previewReady)
          CameraPreview(controller)
        else
          Container(color: AppPalette.black),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppPalette.black.withValues(alpha: AppOpacity.rich),
                  AppPalette.black.withValues(alpha: AppOpacity.none),
                  AppPalette.black.withValues(alpha: AppOpacity.overlayStrong),
                ],
                stops: const [0.0, 0.34, 1.0],
              ),
            ),
          ),
        ),
        if (!previewReady)
          CheckinCameraPlaceholder(
            message: _isInitializingCamera
                ? widget.overview.loadingLabel
                : (_cameraError ?? widget.overview.messages.cameraUnavailable),
          ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CheckinTopBar(
            closeSemantics: widget.overview.closeSemantics,
            flashSemantics: widget.overview.flashSemantics,
            switchCameraSemantics: widget.overview.switchCameraSemantics,
            flashEnabled: _flashEnabled,
            onCloseTap: widget.onBackTap,
            onFlashTap: _toggleFlash,
            onSwitchCameraTap: _switchCamera,
          ),
        ),
        if (_activeOverlay != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: AppSize.checkinFilterBottomOffset +
                AppSize.checkinFilterBarHeight +
                AppSpacing.giant,
            child: Padding(
              padding: AppInsets.pageHorizontal,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.giant),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppPalette.black.withValues(alpha: AppOpacity.overlay),
                      AppPalette.black.withValues(alpha: AppOpacity.scrim),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.card),
                  border: Border.all(
                    color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                    width: AppStroke.hairline,
                  ),
                ),
                child: CheckinOverlayView(
                  overlay: _activeOverlay!,
                  compact: true,
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: AppSize.checkinFilterBottomOffset,
          child: Padding(
            padding: AppInsets.pageHorizontal,
            child: CheckinFilterBar(
              items: widget.overview.filters,
              selectedIndex: _selectedFilterIndex,
              onTap: (index) {
                setState(() => _selectedFilterIndex = index);
                widget.onMessage(widget.overview.messages.filterAction);
              },
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: CheckinCaptureBar(
            gallerySemantics: widget.overview.gallerySemantics,
            captureSemantics: widget.overview.captureSemantics,
            onGalleryTap: () => widget.onMessage(widget.overview.messages.filterAction),
            onCaptureTap: _capture,
          ),
        ),
        if (_isCapturing)
          Positioned.fill(
            child: ColoredBox(
              color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 28,
          child: IgnorePointer(
            child: Center(
              child: Container(
                width: AppSize.checkinCaptureOuter,
                height: AppSize.checkinCaptureOuter,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppPalette.white.withValues(alpha: AppOpacity.xxs),
                    width: AppStroke.hairline,
                  ),
                ),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scale(
                    begin: const Offset(0.96, 0.96),
                    end: const Offset(1.02, 1.02),
                    duration: AppMotion.checkinCapturePulseDurationMs.ms,
                    curve: Curves.linear,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
