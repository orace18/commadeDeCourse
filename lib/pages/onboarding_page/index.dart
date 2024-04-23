import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/providers/theme/theme.dart';
import 'controllers/onboarding_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OnboardingPage extends GetWidget<OnboardingController> {
  
  List pageInfos = [
    {
      "title": "$appName",
      "body":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      "img": "https://images2.imgbox.com/74/e9/3kp0NqBN_o.png",
      "img_local" : "assets/onboarding/onboarding_1.png",
    },
    {
      "title": "$appName",
      "body":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      "img": "https://images2.imgbox.com/90/f4/hGo1mjcP_o.png",
      "img_local" : "assets/onboarding/onboarding_2.png",
    },
    {
      "title": "$appName",
      "body":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      "img": "https://images2.imgbox.com/ba/b8/mlYgzX2S_o.png",
      "img_local" : "assets/onboarding/onboarding_3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      for (int i = 0; i < pageInfos.length; i++) _buildPageModel(pageInfos[i])
    ];

    return Scaffold(
        body: GetBuilder<OnboardingController>(
          builder: (_) => Scaffold(
            body: IntroductionScreen(
              pages: pages,
              dotsDecorator: DotsDecorator(
                activeColor: Colors.redAccent,
                spacing: EdgeInsets.only(left:5, right: 5, bottom:30)
              ),
              onDone: () {
                final box = GetStorage();
                box.write('onboarding', true);
                Get.toNamed('/connexion');
              },
              onSkip: () {
                final box = GetStorage();
                box.write('onboarding', true);
                Get.off;
              },
              showSkipButton: true,
              skip: Text(
                "skip".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                ),
              ),
              next: Text("next".tr),
              done: Container(
                padding:
                EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: AppTheme.otripMaterial[300],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Text(
                  "done".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  _buildPageModel(Map item) {
    return
      PageViewModel(
      titleWidget: Text(
          item['title'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
          )),
      body: item['body'],
      image: Padding(
        padding: const EdgeInsets.only(
            top: 40.0, left: 15.0, right: 15.0, bottom: 15.0),
        child: Image.asset(
          item['img_local'],
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Colors.black12,
        ),
        bodyTextStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
        pageColor: Colors.white,
      ),
    );
  }
}
