import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/product.dart';
import 'package:udemy_flutter_delivery/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';
import 'package:udemy_flutter_delivery/src/widgets/no_data_widget.dart';

class ClientOrdersCreatePage extends StatelessWidget {
  final ClientOrdersCreateController con =
      Get.put(ClientOrdersCreateController());

  ClientOrdersCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: _totalToPay(context),
        appBar: AppBar(
          title: const Text('Mi orden'),
        ),
        body: con.selectedProducts.isNotEmpty
            ? ListView(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 118),
                children: con.selectedProducts.map((Product product) {
                  return _cardProduct(context, product);
                }).toList(),
              )
            : const NoDataWidget(text: 'No hay productos agregados'),
      ),
    );
  }

  Widget _totalToPay(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 22,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(color: AppColors.muted, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$${con.total.value}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => con.goToAddressList(),
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(14),
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
                      const SizedBox(height: 10),
                      _buttonsAddOrRemove(product),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _textPrice(product),
                    const SizedBox(height: 8),
                    _iconDelete(product),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconDelete(Product product) {
    return IconButton(
      onPressed: () => con.deleteItem(product),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.danger.withValues(alpha: 0.1),
        foregroundColor: AppColors.danger,
      ),
      icon: const Icon(Icons.delete_outline),
    );
  }

  Widget _textPrice(Product product) {
    return Text(
      '\$${product.price! * product.quantity!}',
      style: TextStyle(
        color: AppColors.ink,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buttonsAddOrRemove(Product product) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => con.removeItem(product),
            icon: const Icon(Icons.remove),
            iconSize: 18,
          ),
          SizedBox(
            width: 30,
            child: Text(
              '${product.quantity ?? 0}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          IconButton(
            onPressed: () => con.addItem(product),
            icon: const Icon(Icons.add),
            iconSize: 18,
          ),
        ],
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return SizedBox(
      height: 76,
      width: 76,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
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
}
