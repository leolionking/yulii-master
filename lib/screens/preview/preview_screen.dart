import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/widgets/opacity_button.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({
    Key key,
    @required this.fileUrl,
    @required this.isVideo,
  })  : assert(fileUrl != null),
        super(key: key);

  final String fileUrl;
  final bool isVideo;

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool _showAppBar = true;

  AppBar get appBar => AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.black45,
      );

  @override
  Widget build(BuildContext context) {
    final isVideo = widget.isVideo ?? false;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isVideo ? appBar : null,
      body: SafeArea(
        top: !isVideo,
        bottom: !isVideo,
        child: SizedBox.expand(
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Center(
                child: Builder(
                  builder: (context) {
                    if (widget.isVideo ?? false) {
                      return _VideoPreview(url: widget.fileUrl);
                    }

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _showAppBar = !_showAppBar;
                        });
                      },
                      child: SizedBox.expand(
                        child: CachedNetworkImage(
                          imageUrl: widget.fileUrl,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
                            return Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                              ),
                            );
                          },
                          // fit: BoxFit.contain,
                          errorWidget: (_, __, ___) {
                            return Container(
                              width: double.infinity,
                              height: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Icon(
                                FeatherIcons.alertCircle,
                                color: AppColors.errorColor,
                              ),
                            );
                          },
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              constraints: BoxConstraints(
                                // maxHeight: MediaQuery.of(context).size.height * .7,
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                              margin: const EdgeInsets.only(
                                top: AppDimens.smPadding,
                                bottom: AppDimens.smPadding,
                              ),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (!isVideo)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _showAppBar ? 1 : 0,
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: appBar,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoPreview extends StatefulWidget {
  _VideoPreview({
    Key key,
    @required this.url,
  })  : assert(url != null),
        super(key: key);

  final String url;

  @override
  __VideoPreviewState createState() => __VideoPreviewState();
}

class __VideoPreviewState extends State<_VideoPreview> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  void _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.url);
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayer();
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController?.videoPlayerController?.value?.isInitialized ?? false) {
      return Chewie(
        controller: _chewieController,
      );
    }
    return const Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
