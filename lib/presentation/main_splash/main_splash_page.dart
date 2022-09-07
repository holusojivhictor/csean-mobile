import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MainSplashPage extends StatelessWidget {
  const MainSplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: Text(
                  'CSEAN',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headline5!
                      .copyWith(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(theme.indicatorColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  bool _visible = true;

  late AnimationController animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1500));
  late Animation<double> animation =
      CurvedAnimation(parent: animationController, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Presented by...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Image.asset(
                  'assets/auth/infoscert.png',
                  height: 25.0,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/auth/csean_logo.png',
                width: animation.value * 150,
                height: animation.value * 150,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedTextSplash extends StatelessWidget {
  const AnimatedTextSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Presented by...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Image.asset(
                  'assets/auth/infoscert.png',
                  height: 25.0,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(3),
                child: TextLiquidFill(
                  text: 'CSEAN',
                  waveColor: Colors.black,
                  loadDuration: const Duration(milliseconds: 2500),
                  boxBackgroundColor: theme.scaffoldBackgroundColor,
                  textStyle: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'DejaVuSans'),
                  boxHeight: 85,
                ),
              ),
              SizedBox(
                width: 200,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'CYBER SECURITY EXPERTS ASSOCIATION OF NIGERIA',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontFamily: 'DejaVuSans',
                      ),
                      speed: const Duration(milliseconds: 50),
                      curve: Curves.easeInOut,
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
