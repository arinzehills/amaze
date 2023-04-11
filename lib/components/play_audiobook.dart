import 'dart:async';

import 'package:amaze/components/utilities_widgets/my_navigate.dart';
import 'package:amaze/components/utilities_widgets/url_to_readable.dart';
import 'package:amaze/constants/constants.dart';
import 'package:amaze/models/book_model.dart';
import 'package:amaze/pages/PlayAudio/play_audiopage.dart';
import 'package:amaze/pages/PlayAudio/test_ui.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlayAudioBook extends StatefulWidget {
  const PlayAudioBook({super.key, required this.book});
  final BookModel book;
  @override
  State<PlayAudioBook> createState() => _PlayAudioBookState();
}

class _PlayAudioBookState extends State<PlayAudioBook> {
  AudioPlayer audioPlayer = AudioPlayer();
  StreamController<Duration> _positionController = StreamController<Duration>();
  Duration totalDuration = Duration.zero;
  bool isPlaying = false;
  TextStyle textStyle =
      TextStyle(color: Color.fromARGB(255, 234, 234, 234), fontSize: 16);

  @override
  void initState() {
    super.initState();
    audioPlayer.onPositionChanged.listen((Duration position) {
      _positionController.add(position);
    });
    audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() => totalDuration = d);
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _positionController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.8,
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(12),
            height: 170,
            decoration: BoxDecoration(
                color: myDarkBlue, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lower Primary',
                  style: textStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'None',
                      style: textStyle,
                    ),
                    _buildPlayAudio(),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                _buildAudioProgress()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayAudio() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.fast_rewind_rounded,
                size: 65,
                color: textStyle.color,
              )),
          SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: _playAudio,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                color: textStyle.color,
                size: 65,
              )),
          SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.fast_forward, size: 65, color: textStyle.color)),
        ],
      ),
    );
  }

  _buildAudioProgress() {
    return StreamBuilder(
      stream: _positionController.stream,
      builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
        if (snapshot.hasData) {
          Duration duration = snapshot.data!;
          double value = duration.inSeconds.toDouble() /
              totalDuration.inSeconds.toDouble();
          String progressText =
              '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
          return _linearProgressWidget(context, value, progressText);
        } else {
          return _linearProgressWidget(context, 0.0, '0:00');
        }
      },
    );
    // return Container(
    //   child: LinearProgressIndicator(
    //     // value: double.parse(progress) / 100.0,
    //     value: 3,
    //     color: Colors.white,
    //     // valueColor:
    //     //     AlwaysStoppedAnimation(Theme.of(context).colorScheme.secondary),
    //     // backgroundColor:
    //     //     Theme.of(context).colorScheme.secondary.withOpacity(0.3),
    //   ),
    // );
  }

  _linearProgressWidget(BuildContext context, double value, progressText) {
    return Container(
      width: size(context).width * 0.99,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: value,
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(progressText),
              GestureDetector(
                  onTap: () {
                    // MyNavigate.navigatejustpush(
                    //     PlayAudioPage(book: widget.book), context);
                    MyNavigate.navigatejustpush(
                        AudioPlayerPage(
                          book: widget.book,
                        ),
                        context);
                  },
                  child: Icon(Icons.fullscreen))
            ],
          ),
        ],
      ),
    );
  }

  _playAudio() async {
    try {
      var readableUrl =
          UrlToReadable.videoUrlToReadableURL(widget.book.audioURL!, '.mp3');
      print(UrlToReadable.videoUrlToReadableURL(widget.book.audioURL!, '.mp3'));
      Source source = UrlSource(readableUrl);

      // await _getDuration();
      if (!isPlaying) {
        audioPlayer.play(source);
        setState(() => isPlaying = true);
      } else {
        audioPlayer.pause();
        setState(() => isPlaying = false);
      }
    } catch (e) {
      print('e');
      print(e);
    }
  }
}
