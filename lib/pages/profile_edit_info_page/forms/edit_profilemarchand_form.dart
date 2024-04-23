import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:get/get.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:otrip/pages/profile_edit_info_page/controllers/profile_edit_marchand_controller.dart';

import '../../../constants.dart';
import '../../../providers/theme/theme.dart';

class EditMarchandForm extends GetWidget<ProfileEditMarchandController> {
  const EditMarchandForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = controller.getUserData();
    return Container(
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderTextField(
                name: 'fullname',
                initialValue:
                    "${userData['firstname']} ${userData['lastname']}",
                enabled: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: defaultPadding,
                        horizontal: defaultPadding * 2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(width: 0.5)),
                    hintText: 'fullname'.tr,
                    icon: Icon(Icons.person)),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'field_required'.tr),
                  FormBuilderValidators.minLength(4,
                      errorText: 'string_too_short'.tr),
                  FormBuilderValidators.maxLength(50,
                      errorText: 'string_too_long'.tr),
                ]),
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderPhoneField(
                enabled: true,
                name: 'phone_number',
                initialValue: "${userData['phoneNumber']}",
                inputFormatters: [],
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    hintText: 'phone_number'.tr,
                    icon: Icon(Icons.phone)),
                priorityListByIsoCode: ['BJ'],
                defaultSelectedCountryIsoCode: 'BJ',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ),
            defaultSizedBox,
            Divider(
              thickness: 1,
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderTextField(
                name: 'address',
                initialValue: "",
                enabled: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: defaultPadding,
                        horizontal: defaultPadding * 2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(width: 0.5)),
                    hintText: 'Adresse',
                    icon: Icon(Icons.map)),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'field_required'.tr),
                ]),
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderRadioGroup(
                name: 'gender',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    hintText: 'sexe'.tr,
                    icon: Icon(Icons.male)),
                options: [
                  FormBuilderFieldOption(
                    value: "M",
                    child: Text("male".tr),
                  ),
                  FormBuilderFieldOption(
                    value: "F",
                    child: Text("female".tr),
                  ),
                ],
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderDateTimePicker(
                name: 'birthday',
                inputType: InputType.date,
                //format: DateFormat('dd/MM/yyyy'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: defaultPadding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    hintText: 'birthday'.tr,
                    icon: Icon(Icons.calendar_month)),
              ),
            ),
            defaultSizedBox,
            Divider(
              thickness: 1,
            ),
            defaultSizedBox,
            Text(
              "edit_profile_add_doc".tr,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.left,
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderDropdown(
                name: 'document_type',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: defaultPadding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    hintText: 'document_type'.tr,
                    icon: Icon(Icons.inventory_outlined)),
                items: [
                  DropdownMenuItem(
                    value: "Passport",
                    child: Text("Passport"),
                  ),
                  DropdownMenuItem(
                    value: "National ID",
                    child: Text("national_id".tr),
                  )
                ],
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderTextField(
                name: 'document_number',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: defaultPadding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    hintText: 'document_number'.tr,
                    icon: Icon(Icons.inventory_outlined)),
              ),
            ),
            defaultSizedBox,
            GestureDetector(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result != null &&
                    (result.files.first.extension == "jpg" ||
                        result.files.first.extension == "jpeg" ||
                        result.files.first.extension == "png" ||
                        result.files.first.extension == "gif") &&
                    result.files.first.size <= 4194304) {
                  controller.imagePath.value = result.files.single.path!;
                } else {
                  Get.snackbar(
                      "Error", "Veillez selectionner une image de moins de 4Mo",
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        color: Colors.grey.shade300.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: controller.imagePath.value == ""
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_download_sharp,
                                color: otripOrange,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'select_file'.tr,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              ),
                            ],
                          )
                        : Obx(() {
                            return Image.file(
                              File(controller.imagePath.value),
                            );
                          }),
                  )),
            ),
            Divider(
              thickness: 1,
            ),
            defaultSizedBox,
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
              child: ElevatedButton(
                  child: Text(
                    'continue'.tr,
                    style: TextStyle(
                        color: /*controller.isButtonEnabled.value ? Colors.white :*/
                            Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    elevation: 0,
                    backgroundColor:
                        AppTheme.otripMaterial, //: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () {
                    final form = controller.formKey.currentState;
                    if (form != null && form.saveAndValidate()) {
                      Map<String, dynamic> updatedData = {
                        'firstname':
                            form.fields['fullname']?.value.split(' ')[0],
                        'lastname':
                            form.fields['fullname']?.value.split(' ')[1],
                        'phone_number': form.fields['phone_number']?.value,
                      };
                      // mise à jour sexe, l'anniversaire et l'adresse du formulaire
                      String updatedGender = form.value['gender'] ?? '';
                      DateTime updatedBirthday =
                          form.value['birthday'] ?? DateTime.now();
                      String updatedAddress = form.value['address'] ?? '';
                      controller.updateProfileInfo(
                        updatedGender,
                        updatedBirthday,
                        updatedAddress,
                      );
                      controller.updateProfile(updatedData, updatedGender,
                          updatedBirthday, updatedAddress);
                      Get.toNamed('/profile_marchand');
                      print('Données bien recupérées');
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  // Fonction pour register
  void registerRequest() {
    print("logging");
  }
}
