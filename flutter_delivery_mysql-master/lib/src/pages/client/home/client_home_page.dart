import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/client/home/client_home_controller.dart';
import 'package:udemy_flutter_delivery/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:udemy_flutter_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:udemy_flutter_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';
import 'package:udemy_flutter_delivery/src/utils/custom_animated_bottom_bar.dart';

class ClientHomePage extends StatelessWidget {
  final ClientHomeController con = Get.put(ClientHomeController());

  ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomBar(),
      body: Obx(() => _pageForIndex(con.indexTab.value)),
    );
  }

  Widget _pageForIndex(int index) {
    switch (index) {
      case 1:
        return ClientOrdersListPage();
      case 2:
        return ClientProfileInfoPage();
      default:
        return ClientProductsListPage();
    }
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
                icon: Icon(Icons.apps),
                title: Text('Productos'),
                activeColor: AppColors.primary,
                inactiveColor: AppColors.muted,
                tooltip: 'Productos'),
            BottomNavyBarItem(
              icon: const Icon(Icons.list),
              title: const Text(
                'Pedidos',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.muted,
              tooltip: 'Mis pedidos'),
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
