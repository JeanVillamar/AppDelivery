import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:udemy_flutter_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:udemy_flutter_delivery/src/pages/restaurant/home/restaurant_home_controller.dart';
import 'package:udemy_flutter_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:udemy_flutter_delivery/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';
import 'package:udemy_flutter_delivery/src/utils/custom_animated_bottom_bar.dart';

class RestaurantHomePage extends StatelessWidget {
  final RestaurantHomeController con = Get.put(RestaurantHomeController());

  RestaurantHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() => IndexedStack(
              index: con.indexTab.value,
              children: [
                RestaurantOrdersListPage(),
                RestaurantCategoriesCreatePage(),
                RestaurantProductsCreatePage(),
                ClientProfileInfoPage()
              ],
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
                icon: Icon(Icons.category),
                title: Text('Categoria'),
                activeColor: AppColors.primary,
                inactiveColor: AppColors.muted,
                tooltip: 'Categoria'),
            BottomNavyBarItem(
                icon: Icon(Icons.restaurant),
                title: Text('Producto'),
                activeColor: AppColors.primary,
                inactiveColor: AppColors.muted,
                tooltip: 'Producto'),
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
