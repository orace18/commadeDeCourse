import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme/theme.dart';
import '../controllers/menu_controller.dart' as menu;

class MenuScreen extends StatelessWidget {
  final String imageUrl =
      "https://celebritypets.net/wp-content/uploads/2016/12/Adriana-Lima.jpg";

  final List<MenuItem> options = [
    MenuItem(Icons.search, 'Search'),
    MenuItem(Icons.shopping_basket, 'Performance'),
    MenuItem(Icons.favorite, 'Leaderboard'),
    MenuItem(Icons.code, 'Lessons'),
    MenuItem(Icons.format_list_bulleted, 'Podcast'),
    MenuItem(Icons.format_list_bulleted, 'Store'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        //scroll vers lq gquche du co;posqnt
        if (details.delta.dx < -6) {
          Provider.of<menu.MenuController>(context, listen: false).toggle();
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.otripMaterial
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: AppTheme.otripMaterial[400]
            ),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width*0.8
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(top:50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                image:
                                DecorationImage(image: NetworkImage(imageUrl))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            'name',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Sofia",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        _listText("role".tr, Icons.person,'/role_choose'),

                        _listText("wallet".tr, Icons.wallet,'/wallet_recharge'),

                        _listText("assistance".tr, Icons.assignment_late_sharp, '/support'),

                        _listText("settings".tr, Icons.settings, '/settings'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listText(String _text, IconData _iconData, String routes) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(routes);
      },
   child: Padding(
      padding: EdgeInsets.only(),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                height: 45.0,
                width: 45.0,
                decoration: BoxDecoration(),
                child: Center(
                  child: Icon(
                    _iconData,
                    color: Colors.black38,
                  ),
                ),),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  _text,
                  style: TextStyle(
                      fontFamily: "Sofia",

                      color: Colors.black,
                      fontSize: 16.0),
                )
              ],
            ),
            Divider(height: 10, color: Colors.black,)
          ],
        ),
      ),
    );
  }
}




class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
