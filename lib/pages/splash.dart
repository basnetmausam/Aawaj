import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_try/utils/routes.dart';

import '../data/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _headphonesController;
  bool headphonesAnimated = false;
  bool animateHeadphoneText = false;

  @override
  void initState() {
    super.initState();
    _headphonesController = AnimationController(vsync: this);
    _headphonesController.addListener(() {
      if (_headphonesController.value > 0.7) {
        _headphonesController.stop();
        headphonesAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateHeadphoneText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _headphonesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: themeColor,
      body: Stack(
        children: [
          // White Container top half
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: headphonesAnimated ? screenHeight / 1.9 : screenHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(headphonesAnimated ? 40.0 : 0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !headphonesAnimated,
                  child: Lottie.asset(
                    'assets/audio_wave.json',
                    controller: _headphonesController,
                    onLoaded: (composition) {
                      _headphonesController
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Visibility(
                  visible: headphonesAnimated,
                  child: Image.asset(
                    'assets/logos/logo-transparent.png',
                    height: 190.0,
                    width: 190.0,
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: animateHeadphoneText ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: Text(
                      "Aawaj",
                      style: context.textTheme.headline1,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text bottom part
          Visibility(visible: headphonesAnimated, child: const _BottomPart()),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Emotions that best please you',
              style: GoogleFonts.montserrat(
                  fontSize: 27, color: white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30.0),
            Text(
              'Top of the line music recommendation with Music Emotion Recognition (MER) technology.',
              style: GoogleFonts.montserrat(
                fontSize: 15.0,
                color: white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 50.0),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.homeRoute);
                },
                child: Container(
                  height: 40.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: white, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Open Application",
                        style: GoogleFonts.montserrat(
                          fontSize: 15.0,
                          color: white,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
