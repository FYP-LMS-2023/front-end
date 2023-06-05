import "package:flutter/material.dart";
import 'package:front_end/views/screens/login_page.dart';
import 'package:video_player/video_player.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = VideoPlayerController.asset("assets/videos/animation.mp4")
      ..initialize().then((value) {
        setState(() {});
      })
      ..setVolume(0.0);

    playVideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void playVideo() async {
    controller.play();

    await Future.delayed(const Duration(seconds: 4));

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(
      builder: (_)=> const LoginPage())
      );
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //     child: controller.value.isInitialized ? 
    //     AspectRatio(
    //       aspectRatio: controller.value.aspectRatio,
    //       child: FittedBox(
    //         fit: BoxFit.cover,
    //         child: VideoPlayer(
    //           controller
    //         ),
    //       )
    //     )
    //     : 
    //     Container()
    //   );
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: controller.value.isInitialized ? 
        VideoPlayer(controller)
        : Container()
    );
  }
}