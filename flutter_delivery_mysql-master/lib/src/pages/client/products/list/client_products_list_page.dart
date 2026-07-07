import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/category.dart';
import 'package:udemy_flutter_delivery/src/models/product.dart';
import 'package:udemy_flutter_delivery/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';
import 'package:udemy_flutter_delivery/src/widgets/no_data_widget.dart';
import 'dart:math' as math;

class ClientProductsListPage extends StatelessWidget {
  final ClientProductsListController con =
      Get.put(ClientProductsListController());

  ClientProductsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (con.categories.isEmpty) {
        return Scaffold(
          appBar: _catalogHeader(context, hasTabs: false),
          body: const NoDataWidget(text: 'No hay categorías disponibles'),
        );
      }

      return DefaultTabController(
        length: con.categories.length,
        child: Scaffold(
          appBar: _catalogHeader(context),
          body: TabBarView(
            children: con.categories.map((Category category) {
              return _productsForCategory(context, category);
            }).toList(),
          ),
        ),
      );
    });
  }

  double _catalogHeaderHeight(BuildContext context, {required bool hasTabs}) {
    final textScaler = MediaQuery.textScalerOf(context);

    final titleHeight = textScaler.scale(28);
    final subtitleHeight = textScaler.scale(22);

    const topPadding = 10.0;
    const titleGap = 4.0;
    const gapAfterTitleBlock = 14.0;
    const searchHeight = 48.0;
    const gapBeforeTabs = 10.0;
    const tabsHeight = kTextTabBarHeight;

    const bottomSafetyPadding = 8.0; // clave

    final titleBlockHeight = math.max(
      titleHeight + titleGap + subtitleHeight,
      44.0,
    );

    return topPadding +
        titleBlockHeight +
        gapAfterTitleBlock +
        searchHeight +
        (hasTabs ? gapBeforeTabs + tabsHeight : 0) +
        bottomSafetyPadding;
  }

  PreferredSizeWidget _catalogHeader(
      BuildContext context, {
        bool hasTabs = true,
      }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        _catalogHeaderHeight(context, hasTabs: hasTabs),
      ),
      child: Container(
        color: AppColors.background,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descubre sabores',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Busca y agrega tus favoritos',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                    _iconShoppingBag(),
                  ],
                ),

                const SizedBox(height: 14),

                SizedBox(
                  height: 48,
                  child: _textFieldSearch(),
                ),

                if (hasTabs) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: kTextTabBarHeight,
                    child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: Colors.transparent,
                      tabs: List.generate(con.categories.length, (index) {
                        return Tab(
                          child: Text(
                            con.categories[index].name ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productsForCategory(BuildContext context, Category category) {
    return FutureBuilder(
      future: con.getProducts(category.id ?? '1', con.productName.value),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 96),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (_, index) {
              return _cardProduct(context, snapshot.data![index]);
            },
          );
        }

        return const NoDataWidget(text: 'No hay productos');
      },
    );
  }

  Widget _iconShoppingBag() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton.filled(
          onPressed: () => con.goToOrderCreate(),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.ink,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.shopping_bag_outlined),
        ),
        if (con.items.value > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              constraints: const BoxConstraints(minWidth: 20),
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Text(
                '${con.items.value}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _textFieldSearch() {
    return TextField(
      onChanged: con.onChangeText,
      decoration: const InputDecoration(
        hintText: 'Buscar producto',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => con.openBottomSheet(context, product),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  _productImage(product),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          product.description ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '\$${product.price.toString()}',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.add_circle,
                              color: AppColors.ink,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _productImage(Product product) {
    return SizedBox(
      height: 96,
      width: 96,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
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
