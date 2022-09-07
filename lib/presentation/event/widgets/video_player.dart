import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoUrl;

  const VideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late PlayerState _playerState;
  late YoutubePlayerController _playerController;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _playerController = YoutubePlayerController(
      initialVideoId: widget.videoUrl,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    )..addListener(listener);
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_playerController.value.isFullScreen) {
      setState(() {
        _playerState = _playerController.value.playerState;
      });
    }
  }

  @override
  void deactivate() {
    _playerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return SizedBox(
      child: YoutubePlayer(
        controller: _playerController,
        progressIndicatorColor: primaryColor,
        progressColors: ProgressBarColors(
          playedColor: primaryColor,
          handleColor: primaryColor.withOpacity(0.8),
        ),
        bottomActions: [
          const SizedBox(width: 14.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
              playedColor: primaryColor,
              handleColor: primaryColor.withOpacity(0.8),
            ),
          ),
          RemainingDuration(),
          const SizedBox(width: 14.0),
        ],
        onReady: () => _isPlayerReady = true,
      ),
    );
  }
}
