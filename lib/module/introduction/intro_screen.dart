import 'package:calm/module/introduction/intro_bloc/intro_bloc.dart';
import 'package:calm/module/introduction/intro_bloc/intro_event.dart';
import 'package:calm/module/introduction/intro_bloc/intro_state.dart';
import 'package:calm/gen/assets.gen.dart';
import 'package:calm/module/auth/login_screen.dart';
import 'package:calm/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatelessWidget {
  static const String route = "/intro";
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntroBloc, IntroState>(
      listener: (context, state) {
        if (state.selectedIndex >= 3) {
          Navigator.pushReplacementNamed(context, LoginScreen.route);
          return;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: context.height,
            width: context.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.teal.shade100,
                  Colors.teal.shade300,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    onPageChanged: (value) {
                      context.read<IntroBloc>().add(UpdateIntroIndex(value));
                    },
                    controller: context.watch<IntroBloc>().pageController,
                    children: [
                      _PageViewWidget(
                        image: Assets.images.mindfulness.svg(height: 200),
                        title: "Breathe in Calm",
                        description:
                            "Build a habit of mindfulness with guided practices that help you find peace in every moment.",
                      ),
                      _PageViewWidget(
                        image: Assets.images.activityTracker.svg(height: 200),
                        title: "See Your Calm Grow",
                        description:
                            "Track your meditation and yoga progress as you build a journey toward a calmer, healthier you.",
                      ),
                      _PageViewWidget(
                        image: Assets.images.yoga.svg(height: 200),
                        title: "Flow Into Calm",
                        description:
                            "Rediscover tranquility and flexibility through yoga sessions designed to soothe your mind and body.",
                      ),
                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: context.watch<IntroBloc>().pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.teal.shade900,
                    dotColor: Colors.teal.shade100,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton.outlined(
                      onPressed: () {
                        int selectedIndex =
                            context.read<IntroBloc>().state.selectedIndex;
                        context
                            .read<IntroBloc>()
                            .add(UpdateIntroIndex(selectedIndex + 1));
                      },
                      icon: Icon(
                        context.read<IntroBloc>().state.selectedIndex == 2
                            ? Icons.check_rounded
                            : Icons.arrow_right_alt_rounded,
                      ),
                      color: Colors.teal.shade900,
                      style: OutlinedButton.styleFrom(
                        shape: CircleBorder(),
                        side: BorderSide(
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ),
                    20.widthBox
                  ],
                ),
                20.box,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PageViewWidget extends StatelessWidget {
  final Widget image;
  final String title;
  final String description;

  const _PageViewWidget({
    required this.image,
    required this.title,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image,
        16.box,
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: Text(
            description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
