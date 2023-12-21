import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/add_user_page/widgets/clipper.dart';
import 'package:otrip/providers/theme/theme.dart';
import 'controllers/parrainage_list_conducteur_controller.dart';

class ListConducteurPage extends GetWidget<ListConducteurController> {
  @override
  Widget build(BuildContext context) {
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
                  color: AppTheme.otripMaterial[600],
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            )),
        body: GetBuilder<ListConducteurController>(
          builder: (_) => SafeArea(
            top: false,
            child: Stack(
              children: [
                Column(children: [
                  Expanded(
                    flex: 3,
                    child: ClipPath(
                      clipper: DrawClip(),
                      child: Container(
                        color: AppTheme.otripMaterial,
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "La liste des conducteurs",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      itemCount: controller.people.length,
                      itemBuilder: (context, index) {
                        final person = controller.people[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey), 
                            borderRadius: BorderRadius.circular(8.0), 
                            color: Colors.grey[200], 
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10.0), 
                          padding: EdgeInsets.all(0),
                          child: ListTile(
                            title: Text(
                              '${person.firstName} ${person.lastName}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              ),
                            subtitle: Text(
                              person.phoneNumber,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ));
  }
}
