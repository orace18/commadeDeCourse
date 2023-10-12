import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:otrip/providers/theme/theme.dart';
import 'controllers/onboarding_controller.dart';

class OnboardingPage extends GetWidget<OnboardingController> {
  List pageInfos = [
    {
      "title": "Lorem Ipsum",
      "body":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      "img": "https://images2.imgbox.com/74/e9/3kp0NqBN_o.png",
    },
    {
      "title": "Lorem Ipsum",
      "body":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      "img": "https://images2.imgbox.com/90/f4/hGo1mjcP_o.png",
    },
    {
      "title": "Lorem Ipsum",
      "body":
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
      "img": "https://images2.imgbox.com/ba/b8/mlYgzX2S_o.png",
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
                Get.offNamed('/login');
              },
              onSkip: () {
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
            top: 50.0, left: 15.0, right: 15.0, bottom: 15.0),
        child: Image.network(
          item['img'],
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Colors.black12,
        ),
        bodyTextStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
//        ),
        pageColor: Colors.white,
      ),
    );
  }
}
