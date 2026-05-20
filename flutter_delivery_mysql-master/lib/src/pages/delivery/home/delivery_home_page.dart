import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:udemy_flutter_delivery/src/pages/delivery/home/delivery_home_controller.dart';
import 'package:udemy_flutter_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';
import 'package:udemy_flutter_delivery/src/utils/custom_animated_bottom_bar.dart';

class DeliveryHomePage extends StatelessWidget {
  final DeliveryHomeController con = Get.put(DeliveryHomeController());

  DeliveryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() => IndexedStack(
              index: con.indexTab.value,
              children: [DeliveryOrdersListPage(), ClientProfileInfoPage()],
            )));
  }

  Widget _bottomBar() {
    return Obx(() => CustomAnimatedBottomBar(
          containerHeight: 68,
          backgroundColor: AppColors.surface,
          showElevation: true,
          itemCornerRadius: 18,
          curve: Curves.easeOutCubic,
          selectedIndex: con.indexTab.value,
          onItemSelected: (index) => con.changeTab(index),
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.list),
                title: Text('Pedidos'),
                activeColor: AppColors.primary,
                inactiveColor: AppColors.muted,
                tooltip: 'Pedidos'),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Perfil'),
                activeColor: AppColors.primary,
                inactiveColor: AppColors.muted,
                tooltip: 'Perfil'),
          ],
        ));
  }
}
