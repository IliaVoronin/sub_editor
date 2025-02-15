import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_editor/logic/cubits/subtitle_box_cubit/subtitle_box_state.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_style.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper.dart';
import 'package:video_player/video_player.dart';
import '../../logic/cubits/subtitle_box_cubit/subtitle_box_cubit.dart';

class Home extends StatefulWidget {
  final VideoPlayerController controller;
  final SubtitleBoxCubit subtitleBoxCubit;

  const Home(
      {super.key,
      required this.subtitleBoxCubit,
      required this.controller});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.subtitleBoxCubit,
      child: BlocBuilder<SubtitleBoxCubit, SubtitleBoxState>(
        builder: (context, state) {
          return Column(children: [
            Stack(
              children: [
                //video player
                SubtitleWrapper(
                  videoPlayerController: widget.controller,
                  subtitleController: widget.subtitleBoxCubit.subController,
                  subtitleStyle: const SubtitleStyle(
                    fontSize: 30,
                    textColor: Colors.white,
                    hasBorder: true,
                  ),
                  videoChild: widget.controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: 16.0 / 9.0,
                          child: VideoPlayer(widget.controller),
                        )
                      : Container(),
                ),

                Positioned(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.controller.value.position.toString()} / ${widget.controller.value.duration.toString()}',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
                //progress bar
                Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 20,
                    child: VideoProgressIndicator(
                      widget.controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        backgroundColor: Color.fromARGB(50, 0, 0, 0),
                        bufferedColor: Color.fromARGB(200, 158, 158, 158),
                        playedColor: Color.fromARGB(250, 244, 67, 54),
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      widget.controller.seekTo(Duration(
                          seconds:
                              widget.controller.value.position.inSeconds - 1));

                      setState(() {});
                    },
                    icon: const Icon(Icons.fast_rewind)),
                IconButton(
                    onPressed: () {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.pause();
                      } else {
                        widget.controller.play();
                      }

                      setState(() {});
                    },
                    icon: Icon(widget.controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow)),
                IconButton(
                    onPressed: () {
                      widget.controller.seekTo(const Duration(seconds: 0));

                      setState(() {});
                    },
                    icon: const Icon(Icons.stop)),
                IconButton(
                    onPressed: () {
                      widget.controller.seekTo(Duration(
                          seconds:
                              widget.controller.value.position.inSeconds + 1));

                      setState(() {});
                    },
                    icon: const Icon(Icons.fast_forward)),
              ],
            )
          ]);
        },
      ),
    );
  }
}
