import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/add_user_page/widgets/clipper.dart';
import 'package:otrip/providers/theme/theme.dart';
import 'controllers/parrainage_list_conducteur_controller.dart';

class ListConducteurPage extends GetWidget<ListConducteurController> {
  final ListConducteurController _controller =
      Get.put(ListConducteurController());

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
                    flex: 6,
                    child: ListView.builder(
                      itemCount: _controller.drivers.length,
                      itemBuilder: (context, index) {
                        Driver driver = controller.drivers[index];
                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            title: Text(
                              '${driver.firstname} ${driver.lastname}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              driver.phoneNumber,
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
