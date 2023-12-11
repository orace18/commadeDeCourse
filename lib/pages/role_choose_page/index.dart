import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/role_choose_page/widgets/grid_item.dart';
import '../../constants.dart';
import '../../providers/theme/theme.dart';
import '../add_user_page/widgets/clipper.dart';
import 'controllers/role_choose_controller.dart';

class RoleChoosePage extends GetWidget<RoleChooseController> {

  List <Map<String, String>> roles = [
    {
      "title" : "merchant".tr,
      "image_path" : "assets/logos/moov_momo.png",
      "role_details" : "merchant_details".tr
    },
    {
      "title" : "feeder".tr,
      "image_path" : "assets/logos/moov_momo.png",
      "role_details" : "feeder_details".tr
    },
    {
      "title" : "driver".tr,
      "image_path" : "assets/logos/moov_momo.png",
      "role_details" : "driver_details".tr
    },
    {
      "title" : "passenger".tr,
      "image_path" : "assets/logos/moov_momo.png",
      "role_details" : "passenger_details".tr
    },
    {
      "title" : "society".tr,
      "image_path" : "assets/logos/moov_momo.png",
      "role_details" : "society_details".tr
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<RoleChooseController>(
          builder: (_) => SafeArea(
              top: false,
              child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: ClipPath(
                            clipper: DrawClip(),
                            child: Container(
                              color: AppTheme.otripMaterial,
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom:75.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("choose_a_profile".tr, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("can_change_profile_later".tr, style: TextStyle(color: Colors.white, fontSize: 14),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 6,
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            padding: EdgeInsets.fromLTRB(8.0, 0 ,8.0,8.0),
                            physics: BouncingScrollPhysics(),
                            children: _buildGridView(roles),
                          ),
                        )
                      ],
                    ),
                  ]
              )
          ),
        )
    );
  }

  List<Widget> _buildGridView(List<Map<String, String>> itemList){
    List<Widget> gridItems = [];
    for (Map role in itemList){
      gridItems.add(RoleGridViewItem(
          title: role["title"],
          imagePath: role["image_path"],
          details: () {
            print("bb");
            Get.bottomSheet(
                Container(
                  height: Get.height *0.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    )
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*2, defaultPadding, 0),
                          child: Column(
                            children: [
                              Text(
                                role["title"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                              Text(
                                  role["role_details"]
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(defaultPadding*2, defaultPadding, defaultPadding*2, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            elevation: 0,
                            backgroundColor: AppTheme.otripMaterial,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                          onPressed: (){
                            Get.toNamed("/register",arguments: {"role" : role["text"]});
                          },
                          child: Text('continue'.tr, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                )
            );
          }, description: role["role_details"],
        )
      );
    }
    return gridItems;
  }
}
