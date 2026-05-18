// ─── Video preview with tap to play ───────────────────────────────────────
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  const VideoPreview( {super.key, required this.file});
  final File file;

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        if (mounted) setState(() => _initialized = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return GestureDetector(
      // ✅ Tap করলে fullscreen player খুলবে
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => _FullScreenVideoPlayer(file: widget.file),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
          const Center(
            child: Icon(
              Icons.play_circle_fill_rounded,
              color: Colors.white70,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Fullscreen Video Player ───────────────────────────────────────────────
class _FullScreenVideoPlayer extends StatefulWidget {
  const _FullScreenVideoPlayer({required this.file});
  final File file;

  @override
  State<_FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<_FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _initialized = true);
          _controller.play(); // ✅ open হলেই auto play
        }
      });

    // ✅ Video শেষ হলে আবার শুরু থেকে
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _controller.seekTo(Duration.zero);
        _controller.pause();
        if (mounted) setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // ✅ Video
            Center(
              child: _initialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(color: Colors.white),
            ),

            // ✅ Controls overlay
            if (_showControls) ...[
              // Back button
              Positioned(
                top: 40,
                left: 12,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Play/Pause + Progress bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Progress bar
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true, // ✅ seek করা যাবে
                        colors: const VideoProgressColors(
                          playedColor: Colors.white,
                          bufferedColor: Colors.white38,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Play/Pause
                          GestureDetector(
                            onTap: _togglePlayPause,
                            child: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Duration
                          ValueListenableBuilder(
                            valueListenable: _controller,
                            builder: (_, value, _) => Text(
                              '${_formatDuration(value.position)} / ${_formatDuration(value.duration)}',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}