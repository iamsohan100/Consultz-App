// lib/core/utils/widgets/video_place_holder.dart

import 'dart:typed_data';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  VideoPlaceholder  — thumbnail + fullscreen button
// ═══════════════════════════════════════════════════════════════════════════
class VideoPlaceholder extends StatefulWidget {
  const VideoPlaceholder({
    super.key,
    required this.url,
    this.isSingle,
  });

  final String url;
  final bool? isSingle;

  @override
  State<VideoPlaceholder> createState() => _VideoPlaceholderState();
}

class _VideoPlaceholderState extends State<VideoPlaceholder> {
  Uint8List? _thumbnail;
  bool _thumbnailLoading = true;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    try {
      final bytes = await VideoThumbnail.thumbnailData(
        video: widget.url,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 800,
        quality: 80,
        timeMs: 1000,
      );
      if (mounted) {
        setState(() {
          _thumbnail = bytes;
          _thumbnailLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _thumbnailLoading = false);
    }
  }

  void _openFullScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenVideoPlayer(
          url: widget.url,
          thumbnail: _thumbnail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = Screen.screenWidth(context);
    final double scaleFactor = width / Screen.designWidth;
    final double radius = widget.isSingle == true ? 0 : scaleFactor * 6;

    return GestureDetector(
      onTap: _openFullScreen,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              // ── Thumbnail / fallback ───────────────────────────────────
              if (_thumbnailLoading)
                Container(color: Colors.black87)
              else if (_thumbnail != null)
                Image.memory(_thumbnail!, fit: BoxFit.cover)
              else
                Container(color: Colors.black87),

              // ── Dark overlay ───────────────────────────────────────────
              Container(color: Colors.black.withValues(alpha: 0.3)),

              // ── Play button ────────────────────────────────────────────
              Center(
                child: Container(
                  padding: EdgeInsets.all(scaleFactor * 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    shape: BoxShape.circle,
                  ),
                  child: _thumbnailLoading
                      ? SizedBox(
                          width: scaleFactor * 28,
                          height: scaleFactor * 28,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.white,
                          size: scaleFactor * 40,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  Full Screen Video Player — separate page, portrait mode
// ═══════════════════════════════════════════════════════════════════════════
class FullScreenVideoPlayer extends StatefulWidget {
  const FullScreenVideoPlayer({
    super.key,
    required this.url,
    this.thumbnail,
  });

  final String url;
  final Uint8List? thumbnail;

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _showControls = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await _controller.initialize();
    _controller.addListener(() {
      if (!mounted) return;
      // Reset when video ends
      if (_controller.value.position >= _controller.value.duration) {
        setState(() => _isPlaying = false);
        _controller.seekTo(Duration.zero);
        _controller.pause();
      } else {
        setState(() => _isPlaying = _controller.value.isPlaying);
      }
    });
    if (mounted) {
      setState(() => _initialized = true);
      await _controller.play();
      setState(() => _isPlaying = true);
    }
  }

  void _toggleControls() =>
      setState(() => _showControls = !_showControls);

  void _togglePlayPause() {
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = Screen.screenWidth(context);
    final double height = Screen.screenHeight(context);
    final double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: _toggleControls,
          child: Column(
            children: [
              // ── Top bar ────────────────────────────────────────────────
              AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.4),
                  padding: EdgeInsets.symmetric(
                    horizontal: scaleFactor * 8,
                    vertical: scaleFactor * 4,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: scaleFactor * 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Video area ─────────────────────────────────────────────
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Video or thumbnail
                    if (_initialized)
                      Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    else if (widget.thumbnail != null)
                      Image.memory(
                        widget.thumbnail!,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      )
                    else
                      const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),

                    // Controls overlay
                    AnimatedOpacity(
                      opacity: _showControls ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        child: Center(
                          child: GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              padding: EdgeInsets.all(scaleFactor * 12),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.55),
                                shape: BoxShape.circle,
                              ),
                              child: !_initialized
                                  ? SizedBox(
                                      width: scaleFactor * 32,
                                      height: scaleFactor * 32,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : Icon(
                                      _isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: scaleFactor * 52,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Bottom progress bar ────────────────────────────────────
              if (_initialized)
                AnimatedOpacity(
                  opacity: _showControls ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.4),
                    padding: EdgeInsets.symmetric(
                      horizontal: scaleFactor * 16,
                      vertical: scaleFactor * 10,
                    ),
                    child: Column(
                      children: [
                        // Position / duration
                        ValueListenableBuilder<VideoPlayerValue>(
                          valueListenable: _controller,
                          builder: (_, value, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(value.position),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  _formatDuration(value.duration),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: height * 0.005),
                        // Scrubable progress bar
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                            playedColor: AppColors.primaryColor,
                            bufferedColor: Colors.white38,
                            backgroundColor: Colors.white12,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}