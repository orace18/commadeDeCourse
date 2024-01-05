import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/home_page/widgets/drawer_screen.dart';
import 'package:otrip/pages/home_page/widgets/screen_home_page.dart';
import '../../constants.dart';
import 'widgets/bottom_tabs_navigator.dart';
import 'widgets/tab_page_switcher.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'controllers/menu_controller.dart' as menu;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  menu.MenuController? menuController;

  @override
  void initState() {
    super.initState();

    menuController = menu.MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => menuController,
      child: ScreenHomePage(
        menuScreen: MenuScreen(),
        contentScreen: Layout(
            contentBuilder: (cc) => Container(
              color: Colors.grey[200],
              child: Container(
                color: Colors.grey[200],
              ),
            )),
      ),
    );
  }
}

class Layout {
  final WidgetBuilder? contentBuilder;

  Layout({
    this.contentBuilder,
  });
}
