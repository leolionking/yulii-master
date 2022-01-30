import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/localizations.dart';
import 'package:yulli/routing/app_router.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({
    Key key,
    this.fromSettings = false,
  }) : super(key: key);

  final bool fromSettings;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    final localization = AppLocalization.of(context);

    final isUndexXsHeight = MediaQuery.of(context).size.height < 812.0;

    final defaultDescription = TextStyle(
      fontSize: isUndexXsHeight ? 15 : null,
    );

    final titleTextStyle = TextStyle(
      color: AppColors.secondary,
      fontSize: isUndexXsHeight ? 20 : 22,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: fromSettings
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary,
                  Colors.white,
                ],
              ),
            ),
          ),
          IntroductionScreen(
            rawPages: [
              Stack(
                children: [
                  SizedBox.expand(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: FractionallySizedBox(
                        heightFactor: 0.5,
                        widthFactor: 1,
                        child: Image.asset(
                          AssetImages.rotatedFlower,
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: SizedBox.expand(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimens.lgPadding,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: AppDimens.xlPadding,
                            ),
                            Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.6,
                                child: Image.asset(
                                  AssetImages.yulliLogo,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (!isUndexXsHeight
                                      ? AppDimens.xxlPaddingDouble
                                      : AppDimens.xxlPadding) +
                                  AppDimens.xlPadding,
                            ),
                            Text(
                              localization.onboarding.pageOne.title
                                  .toUpperCase(),
                              style: titleTextStyle,
                            ),
                            const SizedBox(
                              height: AppDimens.padding,
                            ),
                            Text(
                              localization.onboarding.pageOne.description,
                              style: defaultDescription,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.lgPadding,
                    vertical: AppDimens.lgPadding,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: !isUndexXsHeight ? 0.4 : .35,
                          child: Image.asset(
                            AssetImages.yulliLogo,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: !isUndexXsHeight
                            ? AppDimens.xlPadding
                            : AppDimens.mdPadding,
                      ),
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: !isUndexXsHeight ? 0.4 : .35,
                          child: Image.asset(
                            AssetImages.investData,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Text(
                        localization.onboarding.pageTwo.title.toUpperCase(),
                        style: titleTextStyle,
                      ),
                      const SizedBox(
                        height: AppDimens.padding,
                      ),
                      Text(
                        localization.onboarding.pageTwo.description,
                        style: defaultDescription,
                      )
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    top: AppDimens.xxlPaddingDouble +
                        AppDimens.xlPadding +
                        AppDimens.xlPadding,
                    right: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset(
                        AssetImages.giftInHand,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.lgPadding,
                        vertical: AppDimens.lgPadding,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: FractionallySizedBox(
                              widthFactor: 0.4,
                              child: Image.asset(
                                AssetImages.yulliLogo,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.lgPadding,
                          ),
                          Text(
                            localization.onboarding.pageThree.title
                                .toUpperCase(),
                            style: titleTextStyle,
                          ),
                          const SizedBox(
                            height: AppDimens.mdPadding,
                          ),
                          Text(
                            localization.onboarding.pageThree.description,
                            style: defaultDescription,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.lgPadding,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: AppDimens.lgPadding,
                      ),
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.4,
                          child: Image.asset(
                            AssetImages.yulliLogo,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppDimens.xlPadding,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          AssetImages.peopleConnected,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: AppDimens.xlPadding,
                      ),
                      Text(
                        localization.onboarding.pageFour.title.toUpperCase(),
                        style: titleTextStyle,
                      ),
                      const SizedBox(
                        height: AppDimens.padding,
                      ),
                      Text(
                        localization.onboarding.pageFour.description,
                        style: defaultDescription,
                      )
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.lgPadding,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: AppDimens.lgPadding,
                      ),
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.4,
                          child: Image.asset(
                            AssetImages.yulliLogo,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppDimens.xlPadding,
                      ),
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: Image.asset(
                            AssetImages.happyAtWork,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppDimens.xlPadding,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          localization.onboarding.pageFive.title.toUpperCase(),
                          style: titleTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: AppDimens.padding,
                      ),
                      Text(
                        localization.onboarding.pageFive.description,
                        style: defaultDescription,
                      )
                    ],
                  ),
                ),
              ),
            ],
            showSkipButton: true,
            showDoneButton: true,
            globalBackgroundColor: Colors.transparent,
            skip: Text(localization.actions.ignore),
            done: const Icon(FeatherIcons.check),
            next: const Icon(FeatherIcons.arrowRight),
            skipColor: const Color(0xFFa4a2a2),
            onSkip: () async {
              if (fromSettings) {
                return Navigator.of(context).pop();
              }
              await Provider.of<DbService>(context, listen: false)
                  .setHasAlreadySeenOnboarding();
              AppRouter().goToSignIn(context, clearStack: true);
            },
            onDone: () async {
              if (fromSettings) {
                return Navigator.of(context).pop();
              }
              await Provider.of<DbService>(context, listen: false)
                  .setHasAlreadySeenOnboarding();
              AppRouter().goToSignIn(context, clearStack: true);
            },
            dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: AppColors.primary,
              color: const Color(0xFFD8D8D8),
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
