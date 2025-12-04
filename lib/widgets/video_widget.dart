import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/component_model.dart';


class VideoWidget extends StatefulWidget {
  final VideoModel model;
  const VideoWidget(this.model, {super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController? _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.model.url)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {
          _initialized = true;
        });
        if (widget.model.autoPlay) {
          _controller?.play();
        }
        _controller?.setLooping(widget.model.loop);
      }).catchError((err) {
        // simple error handling; keep UI stable
        debugPrint('Video initialize error: $err');
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.model.height ?? 200.0;
    if (widget.model.url.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('No video URL')),
      );
    }

    if (!_initialized || _controller == null) {
      return SizedBox(
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: FloatingActionButton.small(
              onPressed: () {
                setState(() {
                  if (_controller!.value.isPlaying) {
                    _controller!.pause();
                  } else {
                    _controller!.play();
                  }
                });
              },
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
