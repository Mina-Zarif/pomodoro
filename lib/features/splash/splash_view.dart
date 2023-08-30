import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro/constants.dart';
import 'package:pomodoro/features/pomo/presentation/view/pomo_view/pomo_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();
    // navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Color(0xfffdf0f1),
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          top: MediaQuery.of(context).size.height * .27,
          bottom: 25,
        ),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "assets/icons/panadora_logo.png",
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Panadora",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Color(0xff471515),
              ),
            ),
            SizedBox(height: 8),
            DotsIndicator(
              dotsCount: 4,
              mainAxisSize: MainAxisSize.min,
              position: loadingProgress,
              decorator: DotsDecorator(
                color: isDark ? Color(0xfffdf0f1) : Color(0xff471515),
                activeColor: isDark ? Color(0xff6d6969) : Color(0xff8c6969),
              ),
            ),
            Spacer(),
            Text(
              "MADE BY VERTEX",
              style: TextStyle(
                  color: isDark ? Colors.white : Color(0xff471515),
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  void startLoadingAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        if (loadingProgress == 3) {
          navigateToHome();
        } else {
          loadingProgress = (loadingProgress + 1) % (4);
          startLoadingAnimation();
        }
      });
    });
  }

  void navigateToHome() {
    Future.delayed(Duration(seconds: 0), () {
      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.fade,
          isIos: defaultTargetPlatform == TargetPlatform.iOS,
          child: const PomoView(),
          inheritTheme: false,
          ctx: context,
          // duration: Duration(milliseconds: 200),
        ),
      );
    });
  }
}
