import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/product.dart';
import 'package:udemy_flutter_delivery/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';

class ClientProductsDetailPage extends StatelessWidget {
  final Product? product;
  final ClientProductsDetailController con =
      Get.put(ClientProductsDetailController());
  final RxInt counter = 0.obs;
  final RxDouble price = 0.0.obs;

  ClientProductsDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    con.checkIfProductsWasAdded(product!, price, counter);

    return Obx(
      () => Scaffold(
        bottomNavigationBar: _bottomActionBar(),
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            _imageSlideshow(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textNameProduct(context),
                  const SizedBox(height: 12),
                  _textPriceProduct(),
                  const SizedBox(height: 18),
                  _textDescriptionProduct(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textNameProduct(BuildContext context) {
    return Text(
      product?.name ?? '',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 24),
    );
  }

  Widget _textDescriptionProduct() {
    return Text(
      product?.description ?? '',
      style: const TextStyle(
        color: AppColors.muted,
        fontSize: 16,
        height: 1.45,
      ),
    );
  }

  Widget _bottomActionBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
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
        child: Row(
          children: [
            _quantityStepper(),
            const SizedBox(width: 14),
            Expanded(
              child: ElevatedButton(
                onPressed: () => con.addToBag(product!, price, counter),
                child: Text('Agregar  \$${price.value.toStringAsFixed(2)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityStepper() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => con.removeItem(product!, price, counter),
            icon: const Icon(Icons.remove),
            color: AppColors.ink,
          ),
          SizedBox(
            width: 34,
            child: Text(
              '${counter.value}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          IconButton(
            onPressed: () => con.addItem(product!, price, counter),
            icon: const Icon(Icons.add),
            color: AppColors.ink,
          ),
        ],
      ),
    );
  }

  Widget _textPriceProduct() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        '\$${product?.price.toString() ?? ''}',
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _imageSlideshow(BuildContext context) {
    return Stack(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.42,
          initialPage: 0,
          indicatorColor: AppColors.primary,
          indicatorBackgroundColor: Colors.white70,
          children: [
            _productImage(product!.image1),
            _productImage(product!.image2),
            _productImage(product!.image3),
          ],
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: IconButton.filled(
              onPressed: () => Get.back(),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.ink,
              ),
              icon: const Icon(Icons.close),
            ),
          ),
        ),
      ],
    );
  }

  Widget _productImage(String? image) {
    return FadeInImage(
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 120),
      placeholder: const AssetImage('assets/img/no-image.png'),
      image: image != null
          ? NetworkImage(image)
          : const AssetImage('assets/img/no-image.png') as ImageProvider,
    );
  }
}
