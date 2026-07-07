import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter_delivery/src/models/user.dart';
import 'package:udemy_flutter_delivery/src/models/Rol.dart';

class RolesController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  // Sesiones guardadas antes de corregir las rutas en la BD traen rutas a
  // paginas internas sin navbar; se redirigen al home de cada rol.
  static const Map<String, String> _legacyRoutes = {
    '/restaurant/orders/list': '/restaurant/home',
    '/delivery/orders/list': '/delivery/home',
    '/client/products/list': '/client/home',
  };

  void goToPageRol(Rol rol) {
    final route = _legacyRoutes[rol.route] ?? rol.route ?? '';
    Get.offNamedUntil(route, (route) => false);
  }

  void signOut() {
    GetStorage().remove('address');
    GetStorage().remove('shopping_bag');
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false);
  }

}