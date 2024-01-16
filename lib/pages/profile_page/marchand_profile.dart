import 'dart:io';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/profile_page/controllers/profile_marchand_controller.dart';
import 'package:otrip/pages/profile_page/widgets/clipper.dart';
import 'package:phone_number/phone_number.dart';
import '../../providers/theme/theme.dart';
import 'controllers/profile_controller.dart';
import 'package:file_picker/file_picker.dart';

class MarchandProfilePage extends GetWidget<MerchantController> {
  const MarchandProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Récupérez les données du contrôleur du profil
    String gender = controller.gender.value;
    String birthdayString = controller.userData.read('birthday') ?? '';
    DateTime birthday;
    if (birthdayString.isNotEmpty) {
      try {
        birthday = DateTime.parse(birthdayString);
      } catch (e) {
        // Gérer l'erreur de conversion de la date ici
        print('Erreur de parsing de la date : $e');
        // Affectez une valeur par défaut ou faites quelque chose d'autre en cas d'erreur de parsing
        birthday = DateTime
            .now(); // Par exemple, utiliser la date actuelle comme valeur par défaut
      }
    } else {
      // Chaîne de date vide : gérer ce cas selon vos besoins
      birthday = DateTime
          .now(); // Utilisation de la date actuelle comme valeur par défaut
    } // Convertissez la chaîne en DateTime
    String address = controller.address.value;
    //recuperer role
    int? roleId = int.tryParse(controller.getUserRole()) ?? 0;
    String roleName = controller.getRoleFromId(roleId);

    Map<String, dynamic> userData = controller.getUserData();
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: Ink(
              decoration: ShapeDecoration(
                color: AppTheme.otripMaterial[200], // Couleur du bouton
                shape: CircleBorder(), // Forme ronde
              ),
              child: IconButton(
                enableFeedback: true,
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Get.toNamed('/marchand');
                },
              ),
            ),
          ),
        ),
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
                                roleName,
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
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.person),
                                        title: Text('Nom et Prénoms'),
                                        subtitle: Text(
                                            '${userData['firstname']} ${userData['lastname']}'),
                                        onTap: () {
                                          Get.toNamed("/profile_edit_marchand");
                                        },
                                        trailing: IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            Get.toNamed(
                                                "/profile_edit_marchand");
                                          },
                                        ),
                                      ),
                                      Divider(),
                                      ListTile(
                                        leading: Icon(Icons.phone),
                                        title: Text("Téléphone"),
                                        subtitle: Text(
                                            userData['phone_number'] ?? ''),
                                      ),
                                      Divider(),
                                      ListTile(
                                        leading: Icon(Icons.male),
                                        title: Text("Sexe"),
                                        subtitle: Text(gender),
                                      ),
                                      Divider(),
                                      ListTile(
                                        leading: Icon(Icons.calendar_today),
                                        title: Text("Date de naissance"),
                                        subtitle: Text('$birthday'),
                                      ),
                                      Divider(),
                                      ListTile(
                                        leading: Icon(Icons.location_on),
                                        title: Text("Siège"),
                                        subtitle: Text(address),
                                      ),
                                    ],
                                  ),
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
