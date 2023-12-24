import 'dart:io';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/profile_page/controllers/profile_marchand_controller.dart';
import 'package:otrip/pages/profile_page/widgets/clipper.dart';
import '../../providers/theme/theme.dart';
import 'package:file_picker/file_picker.dart';

class MerchantProfilePage extends GetWidget<MerchantController> {
  const MerchantProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String role = controller.getUserRole();
    Map<String, dynamic> userData = controller.getUserData();
    return Scaffold(
        body: GetBuilder<MerchantController>(
            builder: (_) => Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipPath(
                        clipper: DrawClip(),
                        child: Container(
                          height: Get.height,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            gradient: LinearGradient(
                                colors: [
                                  AppTheme.otripMaterial.shade600,
                                  AppTheme.otripMaterial.shade50,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                transform: GradientRotation(4)),
                          ),
                          child: Column(
                            children: [
                              defaultSizedBox,
                              defaultSizedBox,
                              Obx(() {
                                return Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    // Make circle avatar with pathImage or background color grey and selected image with FilePicker
                                    if (controller.imagePath.value != '')
                                      Obx(() {
                                        return CircleAvatar(
                                          radius: circleAvatarRaduis,
                                          backgroundImage: FileImage(
                                              File(controller.imagePath.value)),
                                        );
                                      })
                                    else
                                      CircleAvatar(
                                        radius: circleAvatarRaduis,
                                        backgroundColor: Colors.grey,
                                      ),
                                    //add button to select image
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          print("Called");
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                            type: FileType.image,
                                          );
                                          if (result != null &&
                                              (result.files.first.extension ==
                                                      "jpg" ||
                                                  result.files.first
                                                          .extension ==
                                                      "jpeg" ||
                                                  result.files.first
                                                          .extension ==
                                                      "png" ||
                                                  result.files.first
                                                          .extension ==
                                                      "gif") &&
                                              result.files.first.size <=
                                                  4194304) {
                                            controller.imagePath.value =
                                                result.files.single.path!;
                                          } else {
                                            Get.snackbar("Error",
                                                "Veillez selectionner une image de moins de 4Mo");
                                          }
                                        },
                                        child: Center(
                                            child: Icon(
                                          Icons.camera_alt,
                                          size: 25,
                                          color: Colors.red,
                                        )),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              defaultSizedBox,
                              Text(
                                '${userData['firstname']} ${userData['lastname']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                              defaultSizedBox,
                              Text(
                                role,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: CustomScrollView(
                          primary: false,
                          shrinkWrap: true,
                          slivers: [
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: defaultPadding,
                                    right: defaultPadding),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        '${userData['firstname']} ${userData['lastname']}',
                                      ),
                                      subtitle: Text("profile_name_edit".tr),
                                      onTap: () {
                                        Get.toNamed("/profile_edit_marchand");
                                      },
                                      trailing: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Get.toNamed("/profile_edit_marchand");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )));
  }
}
