import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/product.dart';
import 'package:udemy_flutter_delivery/src/pages/client/orders/detail/client_orders_detail_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';
import 'package:udemy_flutter_delivery/src/utils/relative_time_util.dart';
import 'package:udemy_flutter_delivery/src/widgets/no_data_widget.dart';

class ClientOrdersDetailPage extends StatelessWidget {
  final ClientOrdersDetailController con =
      Get.put(ClientOrdersDetailController());

  ClientOrdersDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: _summaryPanel(context),
        appBar: AppBar(
          title: Text('Orden #${con.order.id}'),
        ),
        body: con.order.products!.isNotEmpty
            ? ListView(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 260),
                children: con.order.products!.map((Product product) {
                  return _cardProduct(context, product);
                }).toList(),
              )
            : const NoDataWidget(text: 'No hay productos agregados'),
      ),
    );
  }

  Widget _summaryPanel(BuildContext context) {
    final isOnWay = con.order.status == 'EN CAMINO';

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: const Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 22,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dataRow(
              icon: Icons.timer_outlined,
              title: 'Fecha del pedido',
              subtitle:
                  RelativeTimeUtil.getRelativeTime(con.order.timestamp ?? 0),
            ),
            _dataRow(
              icon: Icons.person_outline,
              title: 'Repartidor y teléfono',
              subtitle:
                  '${con.order.delivery?.name ?? 'No asignado'} ${con.order.delivery?.lastname ?? ''} - ${con.order.delivery?.phone ?? '###'}',
            ),
            _dataRow(
              icon: Icons.location_on_outlined,
              title: 'Dirección de entrega',
              subtitle: con.order.address?.address ?? '',
            ),
            const Divider(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Total: \$${con.total.value}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (isOnWay) _buttonGoToOrderMap(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _imageProduct(product),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Cantidad: ${product.quantity}',
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return SizedBox(
      height: 58,
      width: 58,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: FadeInImage(
          image: product.image1 != null
              ? NetworkImage(product.image1!)
              : const AssetImage('assets/img/no-image.png') as ImageProvider,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 120),
          placeholder: const AssetImage('assets/img/no-image.png'),
        ),
      ),
    );
  }

  Widget _buttonGoToOrderMap() {
    return ElevatedButton.icon(
      onPressed: () => con.goToOrderMap(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.ink,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      icon: const Icon(Icons.near_me_outlined, size: 18),
      label: const Text('Rastrear'),
    );
  }
}
